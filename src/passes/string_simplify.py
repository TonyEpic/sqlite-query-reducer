"""String-level simplification pass — works without sqlglot parsing.

Uses regex + paren-counting to find simplifiable SQL patterns.  The oracle
validates every candidate, so we can be aggressive.  When a batch oracle is
available, candidates are evaluated in parallel, dramatically speeding up
passes that generate many candidates (e.g. subselect replacement).
"""

from __future__ import annotations

import re
from typing import Callable, List, Optional, Tuple

from .base import Oracle

BatchOracle = Callable[[List[str]], List[bool]]
ProgressHook = Callable[[str], None]


# ── paren-counting helpers for nested structures ────────────────────────

def _find_matching_paren(text: str, start: int) -> int:
    """Return the index of the ``)`` that matches the ``(`` at *start*.

    Returns -1 if no match found.
    """
    depth = 0
    for i in range(start, len(text)):
        if text[i] == '(':
            depth += 1
        elif text[i] == ')':
            depth -= 1
            if depth == 0:
                return i
    return -1


def _find_subselects(text: str) -> List[Tuple[int, int]]:
    """Find ``(SELECT ... FROM ...)`` subqueries using paren-counting.

    Returns list of (start, end) tuples where end is inclusive.
    """
    results: List[Tuple[int, int]] = []
    # Pattern to find candidate starts: "( SELECT" (with optional whitespace)
    for m in re.finditer(r'\(\s*SELECT\b', text, re.IGNORECASE):
        open_pos = m.start()
        close_pos = _find_matching_paren(text, open_pos)
        if close_pos > open_pos:
            # Verify it contains FROM (it's a real subselect, not just a function)
            inner = text[open_pos:close_pos + 1]
            if re.search(r'\bFROM\b', inner, re.IGNORECASE):
                results.append((open_pos, close_pos))
    return results


def _find_exists_blocks(text: str) -> List[Tuple[int, int]]:
    """Find ``EXISTS (SELECT ... FROM ...)`` blocks using paren-counting.

    Returns list of (start, end) tuples where end is inclusive.
    """
    results: List[Tuple[int, int]] = []
    for m in re.finditer(r'\bEXISTS\s*\(', text, re.IGNORECASE):
        open_pos = text.index('(', m.start())
        close_pos = _find_matching_paren(text, open_pos)
        if close_pos > open_pos:
            inner = text[open_pos:close_pos + 1]
            if re.search(r'\bSELECT\b', inner, re.IGNORECASE):
                results.append((m.start(), close_pos))
    return results


def _find_cte_bodies(text: str) -> List[Tuple[int, int, str]]:
    """Find CTE definitions and return (body_start, body_end, cte_prefix).

    For ``cteN AS (SELECT ...)``, returns the SELECT body span and the prefix
    ``"cteN AS ("`` so callers can reconstruct the CTE.
    """
    results: List[Tuple[int, int, str]] = []
    for m in re.finditer(r'(\b\w+\s+AS\s*\()', text, re.IGNORECASE):
        prefix = m.group(1)
        open_pos = m.end() - 1  # position of '('
        close_pos = _find_matching_paren(text, open_pos)
        if close_pos > open_pos:
            inner = text[open_pos + 1:close_pos]
            if re.search(r'\bSELECT\b', inner, re.IGNORECASE):
                results.append((open_pos + 1, close_pos - 1, prefix))
    return results


# ── pass implementation ─────────────────────────────────────────────────

class StringSimplifyPass:
    """String-level reduction pass for unparseable queries.

    Uses regex + paren-counting to find simplifiable patterns.  When a
    ``batch_oracle`` is set by the driver, candidates within each strategy
    are evaluated in parallel — critical for strategies like subselect
    replacement that generate hundreds of candidates.
    """

    name = "string_simplify"

    def __init__(self, batch_oracle: Optional[BatchOracle] = None) -> None:
        self.batch_oracle = batch_oracle
        self.on_progress: Optional[ProgressHook] = None

    def reduce(self, query: str, oracle: Oracle) -> str:
        current = query
        # Order strategies by potential impact: heavy hitters first
        strategies = [
            self._simplify_subselects,
            self._simplify_cte_bodies,
            self._simplify_case_drop,
            self._simplify_case_collapse,
            self._simplify_exists,
            self._simplify_joins,
            self._simplify_tautologies,
            self._simplify_collate,
            self._simplify_boolean_shortcut,
            self._simplify_coalesce_identity,
            self._simplify_order_limit_offset,
        ]

        while True:
            made_progress = False
            for strategy in strategies:
                accepted = self._try_strategy(current, strategy, oracle)
                if accepted is not None and len(accepted) < len(current):
                    current = accepted
                    made_progress = True
                    if self.on_progress:
                        self.on_progress(current)
                    break  # restart from the heaviest strategy
            if not made_progress:
                break
        return current

    def _try_strategy(self, query: str, strategy, oracle: Oracle) -> str | None:
        """Collect all candidates from *strategy*, test them, return first accepted.

        When ``batch_oracle`` is available, candidates are evaluated in
        parallel batches of up to 64 at a time.  Falls back to sequential
        evaluation otherwise.
        """
        # Collect valid (shorter) candidates
        candidates: list[str] = []
        for cand in strategy(query):
            if len(cand) < len(query):
                candidates.append(cand)

        if not candidates:
            return None

        if self.batch_oracle is not None:
            return self._eval_batch(candidates, self.batch_oracle)
        else:
            return self._eval_sequential(candidates, oracle)

    def _eval_batch(self, candidates: list[str], batch: BatchOracle) -> str | None:
        """Evaluate candidates in parallel batches."""
        batch_size = 64
        for i in range(0, len(candidates), batch_size):
            chunk = candidates[i:i + batch_size]
            results = batch(chunk)
            for cand, ok in zip(chunk, results):
                if ok:
                    return cand
        return None

    def _eval_sequential(self, candidates: list[str], oracle: Oracle) -> str | None:
        """Evaluate candidates one at a time."""
        for cand in candidates:
            if oracle(cand):
                return cand
        return None

    # ── Sub-SELECT replacement (paren-counting) ─────────────────────────

    def _simplify_subselects(self, query: str):
        """Replace ``(SELECT ... FROM ...)`` subqueries with constants.

        Uses paren-counting to correctly handle nested subqueries.
        Since t0 is empty, most subqueries return empty sets — the segfault
        is likely planner-triggered.
        """
        for start, end in _find_subselects(query):
            sub = query[start:end + 1]
            for val in ('NULL', 'TRUE', 'FALSE', '0'):
                if len(val) < len(sub):
                    yield query[:start] + val + query[end + 1:]

    # ── EXISTS replacement (paren-counting) ─────────────────────────────

    def _simplify_exists(self, query: str):
        """Replace ``EXISTS (SELECT ...)`` with TRUE/FALSE.

        Uses paren-counting to correctly match nested parentheses.
        """
        for start, end in _find_exists_blocks(query):
            block = query[start:end + 1]
            for val in ('TRUE', 'FALSE'):
                if len(val) < len(block):
                    yield query[:start] + val + query[end + 1:]

    # ── CTE body simplification (paren-counting) ────────────────────────

    def _simplify_cte_bodies(self, query: str):
        """Try replacing each CTE's SELECT body with a simple ``SELECT 1``.

        Uses paren-counting to correctly match the CTE body.
        """
        for body_start, body_end, prefix in _find_cte_bodies(query):
            body = query[body_start:body_end + 1]
            for simple in ('SELECT 1', 'SELECT NULL', 'SELECT TRUE'):
                if len(simple) < len(body):
                    # prefix already includes " AS (", body is the inner SELECT
                    yield query[:body_start] + simple + query[body_end + 1:]

    # ── tautology simplification ────────────────────────────────────────

    _TAUTOLOGY_RE = re.compile(
        r'(\b\w+(?:\.\w+)?)\s*(=|<>|!=|>=|<=|>|<)\s*\1',
        re.IGNORECASE,
    )

    def _simplify_tautologies(self, query: str):
        """Replace ``x = x`` → TRUE, ``x <> x`` → FALSE, etc."""
        for m in self._TAUTOLOGY_RE.finditer(query):
            op = m.group(2).upper()
            if op in ('=', '>=', '<='):
                replacement = 'TRUE'
            elif op in ('<>', '!=', '>', '<'):
                replacement = 'FALSE'
            else:
                continue
            candidate = query[:m.start()] + replacement + query[m.end():]
            if len(candidate) < len(query):
                yield candidate

    # ── CASE branch collapse ────────────────────────────────────────────

    def _simplify_case_collapse(self, query: str):
        """Collapse CASE WHEN ... THEN X ... ELSE X END → X."""
        for m in re.finditer(r'CASE\b.*?\bEND\b', query, re.IGNORECASE | re.DOTALL):
            case_block = m.group(0)
            result = self._try_collapse_case(case_block)
            if result is not None and len(result) < len(case_block):
                candidate = query[:m.start()] + result + query[m.end():]
                yield candidate

    def _try_collapse_case(self, case_text: str) -> str | None:
        """Try to collapse a CASE block. Returns simplified text or None."""
        when_re = re.compile(
            r'WHEN\s+(.+?)\s+THEN\s+(.+?)(?=\s+(?:WHEN|ELSE|END)\b)',
            re.IGNORECASE | re.DOTALL,
        )
        else_re = re.compile(
            r'ELSE\s+(.+?)\s*END\s*$',
            re.IGNORECASE | re.DOTALL,
        )

        when_matches = list(when_re.finditer(case_text))
        else_match = else_re.search(case_text)

        if not when_matches:
            return None

        results = set()
        for wm in when_matches:
            results.add(wm.group(2).strip())

        if else_match:
            results.add(else_match.group(1).strip())

        if len(results) == 1:
            return results.pop()
        return None

    # ── CASE dropping — replace entire CASE with a constant ─────────────

    def _simplify_case_drop(self, query: str):
        """Try replacing entire CASE ... END blocks with constants."""
        for m in re.finditer(r'CASE\b.*?\bEND\b', query, re.IGNORECASE | re.DOTALL):
            case_block = m.group(0)
            for replacement in ('NULL', 'TRUE', 'FALSE', '0', '1'):
                if len(replacement) < len(case_block):
                    yield query[:m.start()] + replacement + query[m.end():]

            first_result = self._extract_first_case_result(case_block)
            if first_result and len(first_result) < len(case_block):
                yield query[:m.start()] + first_result + query[m.end():]

    def _extract_first_case_result(self, case_text: str) -> str | None:
        """Extract the result of the first WHEN...THEN branch in a CASE."""
        m = re.search(r'THEN\s+(.+?)(?=\s+(?:WHEN|ELSE|END)\b)', case_text,
                      re.IGNORECASE | re.DOTALL)
        if m:
            return m.group(1).strip()
        return None

    # ── COLLATE removal ─────────────────────────────────────────────────

    _COLLATE_RE = re.compile(r'\s+COLLATE\s+\w+', re.IGNORECASE)

    def _simplify_collate(self, query: str):
        """Remove COLLATE clauses."""
        for m in self._COLLATE_RE.finditer(query):
            candidate = query[:m.start()] + query[m.end():]
            if len(candidate) < len(query):
                yield candidate

    # ── Boolean short-circuit ───────────────────────────────────────────

    _OR_TRUE_RE = re.compile(r'\bTRUE\s+OR\b', re.IGNORECASE)
    _TRUE_OR_RE = re.compile(r'\bOR\s+TRUE\b', re.IGNORECASE)
    _AND_FALSE_RE = re.compile(r'\bFALSE\s+AND\b', re.IGNORECASE)
    _FALSE_AND_RE = re.compile(r'\bAND\s+FALSE\b', re.IGNORECASE)

    def _simplify_boolean_shortcut(self, query: str):
        """Simplify x OR TRUE → TRUE, x AND FALSE → FALSE."""
        for pattern in (self._OR_TRUE_RE, self._TRUE_OR_RE):
            for m in pattern.finditer(query):
                yield query[:m.start()] + 'TRUE' + query[m.end():]

        for pattern in (self._AND_FALSE_RE, self._FALSE_AND_RE):
            for m in pattern.finditer(query):
                yield query[:m.start()] + 'FALSE' + query[m.end():]

    # ── COALESCE identity ───────────────────────────────────────────────

    def _simplify_coalesce_identity(self, query: str):
        """Simplify COALESCE(x, x) → x."""
        pattern = re.compile(
            r'COALESCE\(\s*((.+?))\s*,\s*\2(?:\s*,\s*\2)*\s*\)',
            re.IGNORECASE,
        )
        for m in pattern.finditer(query):
            replacement = m.group(1)
            candidate = query[:m.start()] + replacement + query[m.end():]
            if len(candidate) < len(query):
                yield candidate

    # ── ORDER BY / LIMIT / OFFSET stripping ─────────────────────────────

    def _simplify_order_limit_offset(self, query: str):
        """Strip ORDER BY, LIMIT, OFFSET, ASC, DESC."""
        for pattern, _ in [
            (re.compile(r'\s+OFFSET\s+\d+', re.I), None),
            (re.compile(r'\s+LIMIT\s+\d+', re.I), None),
            (re.compile(r'\s+ASC\b', re.I), None),
            (re.compile(r'\s+DESC\b', re.I), None),
        ]:
            for m in pattern.finditer(query):
                yield query[:m.start()] + query[m.end():]

    # ── JOIN simplification ─────────────────────────────────────────────

    _JOIN_ON_RE = re.compile(
        r'\s+(LEFT\s+JOIN|RIGHT\s+JOIN|INNER\s+JOIN|CROSS\s+JOIN|JOIN)\s+'
        r'.+?'
        r'\s+ON\s+\((.+?)\)',
        re.IGNORECASE | re.DOTALL,
    )

    def _simplify_joins(self, query: str):
        """Try removing JOINs and simplifying ON conditions."""
        # Remove JOIN ... ON (...) clauses
        for m in self._JOIN_ON_RE.finditer(query):
            candidate = query[:m.start()] + query[m.end():]
            if len(candidate) < len(query):
                yield candidate

        # Simplify ON conditions
        on_re = re.compile(r'\bON\s+\((.+?)\)', re.IGNORECASE | re.DOTALL)
        for m in on_re.finditer(query):
            cond = m.group(1).strip()
            if cond.upper() in ('TRUE', 'FALSE'):
                continue
            yield query[:m.start()] + 'ON (TRUE)' + query[m.end():]
            yield query[:m.start()] + 'ON (FALSE)' + query[m.end():]

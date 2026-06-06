"""Token-level delta debugging (Zeller's ddmin) over the sqlglot token stream.

Classic 1-minimal ddmin: partition the token list into ``n`` chunks, try
removing each chunk (and each chunk-only configuration); on success recurse
with reduced ``n``, otherwise double ``n`` and continue. Stops when ``n``
exceeds the remaining token count.

This implementation evaluates all chunk variants for a given ``n`` in parallel
via the optional ``batch_oracle`` (an OraclePool). When no batch oracle is
provided, it falls back to sequential oracle calls.

The pass emits incremental progress via the optional ``on_progress`` callback
so the entry-point can flush the best candidate even if the process is killed
mid-pass.

If sqlglot cannot tokenize the input, fall back to character-level ddmin so
the reducer always makes progress.
"""

from __future__ import annotations

from typing import Callable, List, Optional, Tuple

import sqlglot

from .base import Oracle

BatchOracle = Callable[[List[str]], List[bool]]
ProgressHook = Callable[[str], None]

_TOKENIZER = sqlglot.Tokenizer()


def _token_spans(query: str) -> List[Tuple[int, int]]:
    spans: List[Tuple[int, int]] = []
    for tok in _TOKENIZER.tokenize(query):
        spans.append((tok.start, tok.end))
    return spans


def _build_query(query: str, spans: List[Tuple[int, int]], keep: List[int]) -> str:
    if not spans:
        return query
    kept = set(keep)
    buf = list(query)
    for i, (s, e) in enumerate(spans):
        if i in kept:
            continue
        for j in range(s, e + 1):
            if 0 <= j < len(buf):
                buf[j] = " "
    return "".join(buf)


def _chunks(items: List[int], n: int) -> List[List[int]]:
    size = max(1, len(items) // n)
    return [items[i : i + size] for i in range(0, len(items), size)]


def _ddmin(items: List[int],
           build: Callable[[List[int]], str],
           oracle: Oracle,
           batch_oracle: Optional[BatchOracle],
           on_progress: Optional[ProgressHook]) -> List[int]:
    """Classic Zeller ddmin with optional parallel chunk evaluation."""
    n = 2
    current = list(items)

    def test_many(keeps: List[List[int]]) -> List[bool]:
        candidates = [build(k) for k in keeps]
        if batch_oracle is not None:
            return batch_oracle(candidates)
        return [oracle(c) for c in candidates]

    while len(current) >= 2:
        chunks = _chunks(current, n)

        complements: List[List[int]] = []
        for chunk in chunks:
            chunk_set = set(chunk)
            complement = [x for x in current if x not in chunk_set]
            complements.append(complement)
        complements_nz = [c for c in complements if c]
        if complements_nz:
            verdicts = test_many(complements_nz)
            best_idx: Optional[int] = None
            best_len = len(current)
            for i, ok in enumerate(verdicts):
                if ok and len(complements_nz[i]) < best_len:
                    best_idx = i
                    best_len = len(complements_nz[i])
            if best_idx is not None:
                current = complements_nz[best_idx]
                n = max(n - 1, 2)
                if on_progress is not None:
                    on_progress(build(current))
                continue

        chunk_only = [c for c in chunks if c]
        if chunk_only:
            verdicts = test_many(chunk_only)
            best_idx = None
            best_len = len(current)
            for i, ok in enumerate(verdicts):
                if ok and len(chunk_only[i]) < best_len:
                    best_idx = i
                    best_len = len(chunk_only[i])
            if best_idx is not None:
                current = chunk_only[best_idx]
                n = 2
                if on_progress is not None:
                    on_progress(build(current))
                continue

        if n >= len(current):
            break
        n = min(n * 2, len(current))
    return current


class TokenDdminPass:
    name = "token_ddmin"

    def __init__(self, batch_oracle: Optional[BatchOracle] = None) -> None:
        self.batch_oracle = batch_oracle
        # Set by the driver so we can emit incremental progress.
        self.on_progress: Optional[ProgressHook] = None

    def reduce(self, query: str, oracle: Oracle) -> str:
        try:
            spans = _token_spans(query)
        except Exception:
            return _char_ddmin(query, oracle, self.batch_oracle, self.on_progress)

        if len(spans) < 2:
            return query

        def build(keep: List[int]) -> str:
            return _build_query(query, spans, keep)

        kept = _ddmin(list(range(len(spans))), build, oracle,
                      self.batch_oracle, self.on_progress)
        return build(kept)


def _char_ddmin(query: str, oracle: Oracle,
                batch_oracle: Optional[BatchOracle],
                on_progress: Optional[ProgressHook]) -> str:
    def build(keep: List[int]) -> str:
        kept = set(keep)
        return "".join(c for i, c in enumerate(query) if i in kept)

    kept = _ddmin(list(range(len(query))), build, oracle,
                  batch_oracle, on_progress)
    kept_set = set(kept)
    return "".join(c for i, c in enumerate(query) if i in kept_set)

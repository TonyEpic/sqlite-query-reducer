"""AST-aware reduction pass using sqlglot's parser.

For each statement in the query, this pass tries grammar-aware simplifications:
removing optional clauses (WHERE, ORDER BY, JOINs, etc.), simplifying column
lists, stripping DDL constraints, and more.  When sqlglot cannot parse a
statement the pass falls back gracefully — no candidates are emitted for
that statement.

Runs between the coarse (statement-level ddmin) and token-level ddmin passes
so that structurally safe simplifications happen before blind token removal.
"""

from __future__ import annotations

from typing import Callable, List, Optional

import sqlglot
from sqlglot import exp

from .base import Oracle

BatchOracle = Callable[[List[str]], List[bool]]
ProgressHook = Callable[[str], None]


def _try_parse(query: str) -> list[exp.Expression] | None:
    """Parse SQL with sqlglot.  Returns ``None`` on failure.

    Filters out ``None`` entries that sqlglot produces for empty statements
    (e.g. stray ``;`` delimiters).
    """
    try:
        parsed = sqlglot.parse(query)
        return [s for s in parsed if s is not None]
    except Exception:
        return None


def _rebuild(statements: list[exp.Expression]) -> str:
    """Rebuild a multi-statement query from a list of parsed expressions."""
    return ";\n".join(stmt.sql() for stmt in statements)


class AstAwareReducerPass:
    """AST-aware reduction pass.

    Parses the query with sqlglot and tries structure-aware simplifications
    on every statement: removing optional clauses (WHERE, ORDER BY, LIMIT,
    GROUP BY, HAVING, DISTINCT), dropping JOINs one by one, pruning SELECT
    columns, stripping CREATE TABLE constraints / columns, simplifying
    CREATE VIEW inner queries, and removing INSERT column lists.

    The driver transparently wraps the oracle with a :class:`CandidateCache`,
    so repeated evaluations of the same candidate are cache hits.
    """

    name = "ast_aware_reducer"

    def __init__(self, batch_oracle: Optional[BatchOracle] = None) -> None:
        self.batch_oracle = batch_oracle
        self.on_progress: Optional[ProgressHook] = None

    # ── public API ──────────────────────────────────────────────────────

    def reduce(self, query: str, oracle: Oracle) -> str:
        current = query
        while True:
            made_progress = False
            for cand in self._candidates(current):
                if len(cand) < len(current) and oracle(cand):
                    current = cand
                    made_progress = True
                    if self.on_progress:
                        self.on_progress(current)
                    break
            if not made_progress:
                break
        return current

    # ── candidate generation ────────────────────────────────────────────

    def _candidates(self, query: str):
        """Yield candidate queries obtained by simplifying one statement."""
        parsed = _try_parse(query)
        if not parsed:
            return

        for i, stmt in enumerate(parsed):
            original_sql = stmt.sql()
            for cand_stmt in self._simplify_statement(stmt):
                try:
                    cand_sql = cand_stmt.sql()
                except Exception:
                    continue
                if cand_sql == original_sql:
                    continue
                rebuilt = list(parsed)
                rebuilt[i] = cand_stmt
                yield _rebuild(rebuilt)

    def _simplify_statement(self, stmt: exp.Expression):
        """Dispatch to the appropriate simplifier for *stmt*."""
        if isinstance(stmt, exp.Select):
            yield from self._simplify_select(stmt)
            yield from self._simplify_nested_selects(stmt)
        elif isinstance(stmt, exp.Create):
            yield from self._simplify_create(stmt)
            yield from self._simplify_nested_selects(stmt)
        elif isinstance(stmt, exp.Insert):
            yield from self._simplify_insert(stmt)
            yield from self._simplify_nested_selects(stmt)

    # ── SELECT simplifications ──────────────────────────────────────────

    def _simplify_select(self, stmt: exp.Select):
        """Yield SELECT variants with optional clauses / items removed."""

        # -- optional clauses (safe to drop) ------------------------------
        for arg_name in ("where", "order", "limit", "group", "having"):
            if stmt.args.get(arg_name):
                new = stmt.copy()
                new.set(arg_name, None)
                yield new

        # -- DISTINCT -----------------------------------------------------
        if stmt.args.get("distinct"):
            new = stmt.copy()
            new.set("distinct", None)
            yield new

        # -- JOINs (try removing one at a time) ---------------------------
        joins = stmt.args.get("joins")
        if joins:
            for idx in range(len(joins)):
                new = stmt.copy()
                new_joins = list(new.args.get("joins", []))
                if idx < len(new_joins):
                    del new_joins[idx]
                    new.set("joins", new_joins if new_joins else None)
                    yield new

        # -- SELECT column list (try removing one column at a time) -------
        exprs = stmt.args.get("expressions")
        if exprs and len(exprs) > 1:
            for idx in range(len(exprs)):
                new = stmt.copy()
                new_exprs = list(new.args.get("expressions", []))
                if idx < len(new_exprs):
                    del new_exprs[idx]
                    new.set("expressions", new_exprs)
                    yield new

    # ── CREATE simplifications ──────────────────────────────────────────

    def _simplify_create(self, stmt: exp.Create):
        kind = (stmt.args.get("kind") or "").upper()
        if kind == "TABLE":
            yield from self._simplify_create_table(stmt)
        elif kind == "VIEW":
            yield from self._simplify_create_view(stmt)

    def _simplify_create_table(self, stmt: exp.Create):
        """Strip column constraints and/or individual columns."""
        this = stmt.this  # exp.Schema
        if this is None:
            return
        columns = this.args.get("expressions") or []
        if not columns:
            return

        # -- drop column constraints (NOT NULL, DEFAULT, PRIMARY KEY, …) --
        for j, col_def in enumerate(columns):
            if col_def.args.get("constraints"):
                new = stmt.copy()
                new_cols = new.this.args.get("expressions", [])
                if j < len(new_cols):
                    new_cols[j].set("constraints", None)
                    yield new

        # -- drop individual columns (only when more than one remain) -----
        if len(columns) > 1:
            for j in range(len(columns)):
                new = stmt.copy()
                new_cols = list(new.this.args.get("expressions", []))
                del new_cols[j]
                new.this.set("expressions", new_cols)
                yield new

    def _simplify_create_view(self, stmt: exp.Create):
        """Simplify the inner SELECT of a CREATE VIEW."""
        inner = stmt.args.get("expression")
        if inner and isinstance(inner, exp.Select):
            for simplified in self._simplify_select(inner):
                new = stmt.copy()
                new.set("expression", simplified)
                yield new

    # ── INSERT simplifications ──────────────────────────────────────────

    def _simplify_insert(self, stmt: exp.Insert):
        """Simplify an INSERT statement: drop column list, remove rows,
        remove columns, simplify nested SELECTs."""
        this = stmt.args.get("this")
        expression = stmt.args.get("expression")

        # -- 1. Remove explicit column list (Schema → Table) -------------
        if isinstance(this, exp.Schema) and this.args.get("expressions"):
            new = stmt.copy()
            new_this = new.args["this"].copy()
            new_this.set("expressions", None)
            new.set("this", new_this)
            yield new

        # -- 2. Simplify nested SELECT in INSERT ... SELECT --------------
        if isinstance(expression, exp.Select):
            for simplified in self._simplify_select(expression):
                new = stmt.copy()
                new.set("expression", simplified)
                yield new

        # -- 3. Remove individual VALUES rows ----------------------------
        if isinstance(expression, exp.Values):
            rows = expression.args.get("expressions") or []
            if len(rows) > 1:
                for idx in range(len(rows)):
                    new = stmt.copy()
                    new_expr = new.args["expression"].copy()
                    new_rows = list(new_expr.args.get("expressions", []))
                    if idx < len(new_rows):
                        del new_rows[idx]
                        new_expr.set("expressions", new_rows)
                        new.set("expression", new_expr)
                        yield new

            # -- 4. Remove individual VALUES columns --------------------
            # We remove the same column position from the column list
            # (if present) and from every row.
            if rows:
                ncols = len(rows[0].args.get("expressions", []))
                if ncols > 1:
                    for col_idx in range(ncols):
                        new = stmt.copy()

                        # Remove from Schema column list
                        if isinstance(new.args["this"], exp.Schema):
                            new_this = new.args["this"].copy()
                            new_schema_cols = list(
                                new_this.args.get("expressions") or []
                            )
                            if col_idx < len(new_schema_cols):
                                del new_schema_cols[col_idx]
                                new_this.set(
                                    "expressions",
                                    new_schema_cols if new_schema_cols else None,
                                )
                            new.set("this", new_this)

                        # Remove from each VALUES row
                        new_expr = new.args["expression"].copy()
                        new_rows = []
                        for row in new_expr.args.get("expressions", []):
                            new_row = row.copy()
                            new_vals = list(
                                new_row.args.get("expressions", [])
                            )
                            if col_idx < len(new_vals):
                                del new_vals[col_idx]
                                new_row.set("expressions", new_vals)
                            new_rows.append(new_row)
                        new_expr.set("expressions", new_rows)
                        new.set("expression", new_expr)
                        yield new

    # ── nested SELECT simplification ────────────────────────────────────

    def _simplify_nested_selects(self, stmt: exp.Expression):
        """Find nested SELECT subqueries and try simplifying them.

        Walks the AST of *stmt*, finds every nested :class:`exp.Select`
        (subqueries in FROM, WHERE, etc.), and for each one tries all the
        standard SELECT simplifications.  Yields a new copy of the whole
        statement for each accepted simplification.
        """
        nested = [
            n for n in stmt.walk()
            if isinstance(n, exp.Select) and n is not stmt
        ]
        if not nested:
            return

        for nested_sel in nested:
            original_sql = nested_sel.sql()
            for simplified in self._simplify_select(nested_sel):
                if simplified.sql() == original_sql:
                    continue
                new_stmt = stmt.copy()
                for orig_node, copy_node in zip(stmt.walk(), new_stmt.walk()):
                    if orig_node is nested_sel:
                        self._replace_child(copy_node, simplified.copy())
                        break
                yield new_stmt

    @staticmethod
    def _replace_child(child: exp.Expression, replacement: exp.Expression) -> None:
        """Replace *child* with *replacement* in its parent's args."""
        parent = getattr(child, "parent", None)
        if parent is None:
            return
        for key, val in list(parent.args.items()):
            if val is child:
                parent.set(key, replacement)
            elif isinstance(val, list):
                parent.set(key, [
                    replacement if x is child else x for x in val
                ])

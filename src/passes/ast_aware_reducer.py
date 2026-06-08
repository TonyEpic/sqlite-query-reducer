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
    """Parse SQL with sqlglot.  Returns ``None`` on total failure.

    First attempts to parse the entire query at once.  If that fails, falls
    back to splitting on ``;`` and parsing each part individually.  Parts
    that still cannot be parsed are replaced with ``None`` in the list so
    callers can preserve the original text for those.

    Filters out ``None`` entries that sqlglot produces for empty statements
    (e.g. stray ``;`` delimiters).
    """
    try:
        parsed = sqlglot.parse(query)
        result = [s for s in parsed if s is not None]
        if result:
            return result
    except Exception:
        pass

    # Fallback: split on ; and parse individual statements
    parts = query.split(";")
    result: list[exp.Expression | None] = []
    any_ok = False
    for part in parts:
        stripped = part.strip()
        if not stripped:
            continue
        try:
            parsed = sqlglot.parse(stripped)
            for s in parsed:
                if s is not None:
                    result.append(s)
                    any_ok = True
        except Exception:
            result.append(None)  # Placeholder for unparseable
    return result if any_ok else None


def _rebuild(statements: list[exp.Expression | str]) -> str:
    """Rebuild a multi-statement query from a list of parsed expressions or str fallbacks."""
    parts = []
    for s in statements:
        if s is None:
            continue
        if isinstance(s, str):
            parts.append(s)
        else:
            parts.append(s.sql())
    return ";\n".join(parts)


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

        # Keep original text parts as fallback for unparseable statements
        orig_parts = query.split(";")

        for i, stmt in enumerate(parsed):
            if stmt is None:
                continue  # Skip unparseable statements
            original_sql = stmt.sql()
            for cand_stmt in self._simplify_statement(stmt):
                try:
                    cand_sql = cand_stmt.sql()
                except Exception:
                    continue
                if cand_sql == original_sql:
                    continue
                rebuilt = list(parsed)  # May contain None placeholders
                rebuilt[i] = cand_stmt
                # Replace None entries with original text for rebuilding
                rebuild_parts: list[exp.Expression | str] = []
                for j, p in enumerate(rebuilt):
                    if p is None:
                        if j < len(orig_parts):
                            rebuild_parts.append(orig_parts[j].strip())
                    else:
                        rebuild_parts.append(p)
                yield _rebuild(rebuild_parts)

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
        for arg_name in ("where", "order", "limit", "group", "having", "offset"):
            if stmt.args.get(arg_name):
                new = stmt.copy()
                new.set(arg_name, None)
                yield new

        # -- CTEs (WITH clauses) — try removing one at a time -------------
        ctes = stmt.args.get("with_") or stmt.args.get("with")
        if ctes:
            cte_exprs = ctes.args.get("expressions", [])
            for idx in range(len(cte_exprs)):
                new = stmt.copy()
                with_key = "with_" if "with_" in new.args else "with"
                new_cte_list = list(new.args[with_key].args.get("expressions", []))
                if idx < len(new_cte_list):
                    del new_cte_list[idx]
                    if new_cte_list:
                        new.args[with_key].set("expressions", new_cte_list)
                    else:
                        new.set(with_key, None)
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

        # -- Expression-level simplifications (tautologies, CASE collapse) -
        yield from self._simplify_expressions(stmt)

    def _simplify_expressions(self, stmt: exp.Expression):
        """Walk the AST and try expression-level simplifications:

        - Tautologies: ``x = x`` → TRUE, ``x <> x`` → FALSE, etc.
        - CASE collapse: all branches → same result → replace with result.
        - EXISTS with WHERE false → FALSE.
        - Short-circuit OR/AND.
        """
        # Tautology / contradiction simplification
        for bin_op in list(stmt.find_all(exp.Binary)):
            try:
                left_sql = bin_op.left.sql()
                right_sql = bin_op.right.sql()
            except Exception:
                continue
            if left_sql == right_sql:
                op = type(bin_op)
                if op in (exp.EQ, exp.GTE, exp.LTE, exp.Is):
                    replacement = exp.Boolean(this=True)
                elif op in (exp.NEQ, exp.LT, exp.GT):
                    replacement = exp.Boolean(this=False)
                else:
                    continue
                # Do an in-place swap, copy, then restore
                parent = bin_op.parent
                if parent is not None and self._swap_in_parent(parent, bin_op, replacement):
                    try:
                        new = stmt.copy()
                        yield new
                    finally:
                        self._swap_in_parent(parent, replacement, bin_op)
                    break  # only yield one from this node type

        # CASE branch collapse: all branches produce the same result
        for case_expr in list(stmt.find_all(exp.Case)):
            try:
                ifs = case_expr.args.get("ifs") or []
                default = case_expr.args.get("default")
                if not ifs:
                    continue
                all_same, result_node = self._case_all_same(ifs, default)
                if all_same and result_node is not None:
                    parent = case_expr.parent
                    if parent is not None and self._swap_in_parent(parent, case_expr, result_node.copy()):
                        try:
                            new = stmt.copy()
                            yield new
                        finally:
                            self._swap_in_parent(parent, result_node.copy(), case_expr)
                        break
            except Exception:
                continue

        # EXISTS with WHERE false → FALSE
        for exists_expr in list(stmt.find_all(exp.Exists)):
            try:
                inner = exists_expr.this
                if isinstance(inner, exp.Select):
                    where_clause = inner.args.get("where")
                    if where_clause is not None:
                        # The Boolean node is nested inside the WHERE wrapper
                        cond = where_clause.this if hasattr(where_clause, 'this') else where_clause
                        if isinstance(cond, exp.Boolean) and cond.this is False:
                            parent = exists_expr.parent
                            if parent is not None and self._swap_in_parent(parent, exists_expr, exp.Boolean(this=False)):
                                try:
                                    new = stmt.copy()
                                    yield new
                                finally:
                                    self._swap_in_parent(parent, exp.Boolean(this=False), exists_expr)
                                break
            except Exception:
                continue

        # Simplify redundant OR: x OR true → true
        for combo_op in list(stmt.find_all(exp.Or)):
            if self._is_boolean_literal(combo_op.left, True) or self._is_boolean_literal(combo_op.right, True):
                parent = combo_op.parent
                if parent is not None and self._swap_in_parent(parent, combo_op, exp.Boolean(this=True)):
                    try:
                        new = stmt.copy()
                        yield new
                    finally:
                        self._swap_in_parent(parent, exp.Boolean(this=True), combo_op)
                    break

        # Simplify redundant AND: x AND false → false
        for combo_op in list(stmt.find_all(exp.And)):
            if self._is_boolean_literal(combo_op.left, False) or self._is_boolean_literal(combo_op.right, False):
                parent = combo_op.parent
                if parent is not None and self._swap_in_parent(parent, combo_op, exp.Boolean(this=False)):
                    try:
                        new = stmt.copy()
                        yield new
                    finally:
                        self._swap_in_parent(parent, exp.Boolean(this=False), combo_op)
                    break

    @staticmethod
    def _is_boolean_literal(node: exp.Expression, value: bool) -> bool:
        """Check if node is a Boolean literal with given value."""
        return isinstance(node, exp.Boolean) and node.this is value

    @staticmethod
    def _case_all_same(ifs: list, default) -> tuple[bool, exp.Expression | None]:
        """Return (True, result_node) if all CASE branches produce the same result."""
        result_sql = None
        result_node = None
        for if_clause in ifs:
            true_branch = if_clause.args.get("true")
            if true_branch:
                r = true_branch.sql()
                if result_sql is None:
                    result_sql = r
                    result_node = true_branch
                elif r != result_sql:
                    return False, None
        if default:
            if result_sql is None:
                result_sql = default.sql()
                result_node = default
            elif default.sql() != result_sql:
                return False, None
        return result_sql is not None, result_node

    @staticmethod
    def _swap_in_parent(parent: exp.Expression, old: exp.Expression, new: exp.Expression) -> bool:
        """Swap old child with new child in parent. Returns True on success."""
        for key, val in list(parent.args.items()):
            if val is old:
                parent.set(key, new)
                return True
            elif isinstance(val, list):
                for i, item in enumerate(val):
                    if item is old:
                        val[i] = new
                        return True
        return False

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

    @staticmethod
    def _replace_node_in_copy(
        tree: exp.Expression,
        target: exp.Expression,
        replacement: exp.Expression,
    ) -> None:
        """Replace *target* with *replacement* in *tree* (mutates tree)."""
        if tree is target:
            return
        for key, val in list(tree.args.items()):
            if val is target:
                tree.set(key, replacement)
            elif isinstance(val, list):
                new_list = []
                for item in val:
                    if item is target:
                        new_list.append(replacement)
                    else:
                        new_list.append(item)
                tree.set(key, new_list)
            elif isinstance(val, exp.Expression):
                AstAwareReducerPass._replace_node_in_copy(val, target, replacement)

## Suggested split 

> **Project 2 — SQL Reducer split (Toni = person 1, Pirmin = person 2)**
>
> Shared decisions to make together first (15 min sync):
> - Language: Python (already scaffolded; uses sqlglot for tokenization/parsing).
> - Internal IR: `sqlglot` AST (`sqlglot.parse_one(sql, read="sqlite")`) plus a flat token list for the fallback reducer.
> - File contract: oracle is invoked via `TEST_CASE_LOCATION` pointing to a temp file (already in the skeleton).
> - Acceptance criterion: oracle exit code 0; cache results by candidate hash to avoid re-running.
>
> **Person 1 (Toni) — Core engine + token-level reduction + infrastructure**
> 1. CLI, file I/O, oracle invocation harness in reducer.py (extend skeleton).
> 2. Candidate cache (hash → exit code) so identical candidates are never re-tested.
> 3. **Token-level ddmin** (Zeller/Hildebrandt) over the sqlglot token stream as the always-available baseline reducer. Greedy single-token deletion + binary-partition ddmin.
> 4. Fixed-point driver: run passes in a loop until no pass makes progress.
> 5. Dockerfile maintenance + a `scripts/eval.py` that runs the reducer over all 20 benchmarks and reports original tokens / final tokens / % reduction / wall-clock.
> 6. Half of the report: Sections "Technical description" and "Implementation".
>
> **Person 2 (Pirmin) — AST-aware reduction passes**
> 1. AST parsing wrapper around `sqlglot.parse_one` with fallback to token-mode when parsing fails.
> 2. **HDD/Perses-style hierarchical reducer**: walk the AST top-down, try to delete or replace each subtree with a smaller equivalent placeholder (`NULL`, `0`, `''`, `TRUE`).
> 3. Targeted SQL-aware passes (each a separate function that returns a list of candidates):
>    - Drop full `ORDER BY`, `LIMIT`, `COLLATE`, `WINDOW`, `WITH` clauses.
>    - Drop individual `WHERE` / `HAVING` predicates (split on `AND`/`OR`).
>    - Drop unused `SELECT` columns / unused tables / unused CTEs.
>    - Collapse `CASE` expressions to a single branch.
>    - Drop unused `CREATE TABLE` columns and corresponding values in `INSERT ... VALUES`.
>    - Drop entire statements (extra `INSERT`s, no-op `PRAGMA`s, etc.).
>    - Shrink long literals (huge integers, long strings).
> 4. Combine passes through Toni's fixed-point driver.
> 5. Half of the report: Sections "Reduction passes" and "Evaluation" (tables + per-benchmark numbers, charts if you like).
>
> Integration points: Pirmin's passes plug into Toni's driver by registering as `Iterable[str]` generators yielding candidate queries. Token-level ddmin runs last on whatever the AST passes produced. We sync on the `Pass` interface after the first commit.


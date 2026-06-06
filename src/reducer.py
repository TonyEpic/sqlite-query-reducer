"""SQL query reducer entry point.

CLI contract (strict — graded automatically):

    reducer --query <path-to-sql-file> --test <path-to-oracle-script>

The reducer rewrites ``--query`` in place with the final minimized query.
The oracle script is invoked with no arguments; it reads the candidate query
from ``./query.sql`` in the CWD or from the path in ``TEST_CASE_LOCATION``
(the reducer always sets the env var). Oracle exit 0 = bug triggers (accept);
exit 1 = bug gone (revert).

On SIGTERM/SIGINT we flush the best candidate found so far to ``--query``
before exiting, so the grader always gets the best result even if it kills us.
"""

from __future__ import annotations

import argparse
import signal
import sys
from pathlib import Path

from .driver import Driver
from .oracle import OraclePool
from .passes.base import Pass
from .passes.token_ddmin import TokenDdminPass


def build_passes() -> list[Pass]:
    """Return the ordered list of reduction passes.

    Order: coarse structural passes first (Pirmin's AST-aware passes will be
    inserted here), token ddmin last as the always-available finisher.
    """
    return [TokenDdminPass()]


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(prog="reducer")
    parser.add_argument("--query", required=True, type=Path,
                        help="Path to the SQL file to minimize (modified in place).")
    parser.add_argument("--test", required=True, type=Path,
                        help="Path to the oracle shell script.")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    query_path: Path = args.query
    original = query_path.read_text(encoding="utf-8")
    pool = OraclePool(args.test)
    driver = Driver(build_passes(), pool)

    # Mutable holder so signal handler + driver can race-safely share the best.
    best = {"query": original}

    def flush_and_exit(signum, frame):  # noqa: ARG001
        try:
            query_path.write_text(best["query"], encoding="utf-8")
        finally:
            sys.exit(128 + (signum or 0))

    signal.signal(signal.SIGTERM, flush_and_exit)
    signal.signal(signal.SIGINT, flush_and_exit)

    def on_progress(candidate: str) -> None:
        best["query"] = candidate

    driver.on_progress = on_progress  # type: ignore[attr-defined]
    minimized = driver.run(original)
    best["query"] = minimized
    query_path.write_text(minimized, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

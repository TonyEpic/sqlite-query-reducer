"""SQL query reducer entry point.

CLI contract (strict — graded automatically):

    reducer --query <path-to-sql-file> --test <path-to-oracle-script>

The reducer rewrites ``--query`` in place with the final minimized query.
The oracle script is invoked with no arguments; it reads the candidate query
from ``./query.sql`` in the CWD or from the path in ``TEST_CASE_LOCATION``.
Oracle exit code 0 means the bug still triggers (accept); 1 means it does
not (revert).
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
import tempfile
from pathlib import Path


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(prog="reducer")
    parser.add_argument("--query", required=True, type=Path,
                        help="Path to the SQL file to minimize (modified in place).")
    parser.add_argument("--test", required=True, type=Path,
                        help="Path to the oracle shell script.")
    return parser.parse_args(argv)


def run_oracle(test_script: Path, candidate: str, workdir: Path) -> bool:
    """Write ``candidate`` to a temp file, invoke the oracle, return True iff exit 0."""
    candidate_path = workdir / "candidate.sql"
    candidate_path.write_text(candidate, encoding="utf-8")
    env = os.environ.copy()
    env["TEST_CASE_LOCATION"] = str(candidate_path)
    result = subprocess.run(
        ["bash", str(test_script.resolve())],
        cwd=workdir,
        env=env,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    return result.returncode == 0


def reduce_query(query: str, test_script: Path) -> str:
    """Return a minimized variant of ``query`` that still passes the oracle.

    Skeleton only — reduction passes go here.
    """
    with tempfile.TemporaryDirectory() as tmp:
        workdir = Path(tmp)
        # Sanity-check: the original must already trigger the bug.
        if not run_oracle(test_script, query, workdir):
            print("warning: oracle does not accept the original query; nothing to do",
                  file=sys.stderr)
            return query

        # TODO: implement reduction passes (ddmin, AST-aware passes, ...).
        return query


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    original = args.query.read_text(encoding="utf-8")
    minimized = reduce_query(original, args.test)
    args.query.write_text(minimized, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

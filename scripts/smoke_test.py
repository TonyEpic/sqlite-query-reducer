"""Smoke-test the driver + token ddmin against a fake oracle.

Validates the algorithm without needing Docker / sqlite3 binaries. The fake
oracle accepts any candidate that still contains the substring "BUG".
"""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT))

from src.passes.token_ddmin import TokenDdminPass
from src.tokens import count_tokens


def fake_oracle(q: str) -> bool:
    return "BUG" in q


def fake_batch_oracle(cs):
    return [fake_oracle(c) for c in cs]


def main() -> int:
    query = """CREATE TABLE t0 (c0 INT, c1 INT, c2 INT);
INSERT INTO t0 VALUES (1, 2, 3), (4, 5, 6), (7, 8, 9);
SELECT c0, c1, c2 FROM t0 WHERE c0 = 1 AND c1 = 2 OR c2 = 3
ORDER BY BUG DESC LIMIT 10;"""

    print(f"original tokens: {count_tokens(query)}")
    print("---")
    print(query)
    print("---")

    p = TokenDdminPass(batch_oracle=fake_batch_oracle)
    reduced = p.reduce(query, fake_oracle)

    print(f"reduced tokens:  {count_tokens(reduced)}")
    print("---")
    print(reduced)
    print("---")
    assert fake_oracle(reduced), "reduced query lost the bug!"
    assert count_tokens(reduced) < count_tokens(query), "no reduction achieved"
    print("OK: parallel ddmin preserved the bug and shrank the query.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

"""Run the reducer over every benchmark and print a results table.

Designed to run inside the grading Docker image (where the sqlite3 binaries
exist), but works anywhere bash + sqlite3-3.26.0 + sqlite3-3.39.4 are on PATH.

Usage (from repo root):
    python scripts/eval.py --queries queries
    python scripts/eval.py --queries queries --only query1,query5
    python scripts/eval.py --queries queries --json results.json
"""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT))

import sqlglot


def count_tokens(query: str) -> int:
    try:
        return len(sqlglot.Tokenizer().tokenize(query))
    except Exception:
        return -1


def run_benchmark(bench_dir: Path, work_dir: Path, reducer_cmd: list[str],
                  timeout: float) -> dict:
    name = bench_dir.name
    original_sql = bench_dir / "original_test.sql"
    test_sh = bench_dir / "test.sh"
    if not original_sql.is_file() or not test_sh.is_file():
        return {"benchmark": name, "skipped": True,
                "reason": "missing original_test.sql or test.sh"}

    work_dir.mkdir(parents=True, exist_ok=True)
    target = work_dir / f"{name}.sql"
    shutil.copy(original_sql, target)
    orig_text = target.read_text(encoding="utf-8")
    orig_tokens = count_tokens(orig_text)

    cmd = reducer_cmd + ["--query", str(target), "--test", str(test_sh.resolve())]
    t0 = time.monotonic()
    try:
        proc = subprocess.run(cmd, timeout=timeout,
                              stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE,
                              text=True)
        elapsed = time.monotonic() - t0
        rc = proc.returncode
        stderr = proc.stderr[-500:] if proc.stderr else ""
    except subprocess.TimeoutExpired:
        elapsed = time.monotonic() - t0
        rc = -1
        stderr = "TIMEOUT"

    final_text = target.read_text(encoding="utf-8")
    final_tokens = count_tokens(final_text)
    reduction = (1 - final_tokens / orig_tokens) * 100 if orig_tokens > 0 else 0.0

    return {
        "benchmark": name,
        "orig_tokens": orig_tokens,
        "final_tokens": final_tokens,
        "reduction_pct": round(reduction, 2),
        "elapsed_s": round(elapsed, 2),
        "exit_code": rc,
        "stderr_tail": stderr,
    }


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--queries", type=Path, default=ROOT / "queries")
    p.add_argument("--work", type=Path, default=ROOT / "out" / "eval")
    p.add_argument("--reducer", type=str, default=None,
                   help="Reducer command (default: 'python -m src.reducer' from repo root)")
    p.add_argument("--only", type=str, default=None,
                   help="Comma-separated list of benchmark names to run")
    p.add_argument("--timeout", type=float, default=600.0)
    p.add_argument("--json", type=Path, default=None)
    args = p.parse_args()

    if args.reducer:
        reducer_cmd = args.reducer.split()
    else:
        reducer_cmd = [sys.executable, "-m", "src.reducer"]

    benches = sorted(
        [d for d in args.queries.iterdir() if d.is_dir() and d.name.startswith("query")],
        key=lambda d: int(d.name.removeprefix("query")),
    )
    if args.only:
        wanted = set(args.only.split(","))
        benches = [b for b in benches if b.name in wanted]

    results = []
    print(f"{'bench':<10} {'orig':>6} {'final':>6} {'%red':>7} {'time_s':>8}  {'rc':>3}")
    print("-" * 50)
    for b in benches:
        r = run_benchmark(b, args.work / b.name, reducer_cmd, args.timeout)
        results.append(r)
        if r.get("skipped"):
            print(f"{b.name:<10} skipped: {r['reason']}")
            continue
        print(f"{r['benchmark']:<10} {r['orig_tokens']:>6} {r['final_tokens']:>6} "
              f"{r['reduction_pct']:>6.2f}% {r['elapsed_s']:>8.2f}  {r['exit_code']:>3}")

    valid = [r for r in results if not r.get("skipped") and r["exit_code"] == 0]
    if valid:
        avg_red = sum(r["reduction_pct"] for r in valid) / len(valid)
        total_t = sum(r["elapsed_s"] for r in valid)
        print("-" * 50)
        print(f"summary: {len(valid)}/{len(results)} ok, "
              f"avg reduction {avg_red:.2f}%, total time {total_t:.2f}s")

    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(results, indent=2), encoding="utf-8")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

"""Oracle invocation.

The reducer never runs SQLite directly — only the oracle (a shell script) does.
The oracle reads its candidate from $TEST_CASE_LOCATION (preferred) or from
./query.sql in CWD. We always set TEST_CASE_LOCATION so we control the path.

OracleRunner: single-worker harness, used directly when serial is fine.
OraclePool:   N-worker thread pool that fans out batches of candidates so
              oracle subprocess latency overlaps. Each worker owns its own
              scratch dir + candidate file (``.worker_<id>.sql`` pattern,
              cleaned up at exit).
"""

from __future__ import annotations

import atexit
import os
import shutil
import subprocess
import tempfile
import threading
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from typing import List


_DEFAULT_TIMEOUT = float(os.environ.get("REDUCER_ORACLE_TIMEOUT", "60") or "60")


class OracleRunner:
    """Single-worker oracle harness."""

    def __init__(self, test_script: Path, worker_id: int = 0,
                 scratch_root: Path | None = None,
                 timeout: float = _DEFAULT_TIMEOUT) -> None:
        self.test_script = test_script.resolve()
        self.worker_id = worker_id
        self.timeout = timeout
        self._scratch = Path(
            scratch_root or tempfile.mkdtemp(prefix=f"reducer_w{worker_id}_")
        )
        self._scratch.mkdir(parents=True, exist_ok=True)
        # Candidate filename pattern recommended by TA (".worker_*.sql"
        # cleaned up at the end).
        self._candidate_path = self._scratch / f".worker_{worker_id}.sql"
        self.calls = 0
        atexit.register(self._cleanup)

    def _cleanup(self) -> None:
        try:
            shutil.rmtree(self._scratch, ignore_errors=True)
        except Exception:
            pass

    def check(self, candidate: str) -> bool:
        """Write ``candidate`` to disk and invoke the oracle.

        Returns True iff the oracle exits 0 (bug still triggers).
        """
        self.calls += 1
        self._candidate_path.write_text(candidate, encoding="utf-8")
        env = os.environ.copy()
        env["TEST_CASE_LOCATION"] = str(self._candidate_path)
        try:
            result = subprocess.run(
                ["bash", str(self.test_script)],
                cwd=self._scratch,
                env=env,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                timeout=self.timeout,
            )
        except subprocess.TimeoutExpired:
            return False
        return result.returncode == 0


class OraclePool:
    """Thread-pool oracle harness for parallel candidate evaluation.

    Each worker thread keeps its own ``OracleRunner`` (and thus its own
    scratch dir + ``.worker_<id>.sql``), so concurrent invocations never
    collide on disk paths. The bottleneck is the bash+sqlite subprocess —
    all GIL-friendly — so threads (not processes) suffice.
    """

    def __init__(self, test_script: Path, workers: int | None = None,
                 timeout: float = _DEFAULT_TIMEOUT) -> None:
        self.test_script = test_script.resolve()
        self.timeout = timeout
        self.workers = workers or max(1, (os.cpu_count() or 1))
        self._scratch_root = Path(tempfile.mkdtemp(prefix="reducer_pool_"))
        self._runners: dict[int, OracleRunner] = {}
        self._runners_lock = threading.Lock()
        self._executor = ThreadPoolExecutor(max_workers=self.workers)
        self.calls = 0
        atexit.register(self._cleanup)

    def _cleanup(self) -> None:
        try:
            self._executor.shutdown(wait=False, cancel_futures=True)
        except Exception:
            pass
        try:
            shutil.rmtree(self._scratch_root, ignore_errors=True)
        except Exception:
            pass

    def _runner_for_thread(self) -> OracleRunner:
        tid = threading.get_ident()
        with self._runners_lock:
            runner = self._runners.get(tid)
            if runner is None:
                worker_id = len(self._runners)
                scratch = self._scratch_root / f"w{worker_id}"
                runner = OracleRunner(self.test_script, worker_id=worker_id,
                                      scratch_root=scratch, timeout=self.timeout)
                self._runners[tid] = runner
            return runner

    def check(self, candidate: str) -> bool:
        self.calls += 1
        return self._runner_for_thread().check(candidate)

    def check_batch(self, candidates: List[str]) -> List[bool]:
        """Evaluate all candidates concurrently. Results returned in order."""
        if not candidates:
            return []
        self.calls += len(candidates)
        # Submit all up front so the pool can saturate every worker; collect in
        # submission order. executor.map() is lazy and can serialize results,
        # so we go through submit() instead.
        futures = [self._executor.submit(self._check_one, c) for c in candidates]
        return [f.result() for f in futures]

    def _check_one(self, candidate: str) -> bool:
        return self._runner_for_thread().check(candidate)

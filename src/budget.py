"""Wall-clock + throughput-based stopping criterion.

The TA explicitly recommends a stopping criterion based on tokens pruned per
second. We track recent pruning throughput in a rolling window; when it falls
below a threshold for long enough, or a hard time budget elapses, we stop.

Both knobs are configurable via env vars so we can tune per-benchmark without
code changes:
- REDUCER_TIME_BUDGET (seconds, default 300)
- REDUCER_MIN_THROUGHPUT (tokens/sec, default 0.05)
- REDUCER_STAGNATION_SECONDS (seconds with throughput<min before stopping, default 30)
"""

from __future__ import annotations

import os
import time
from collections import deque
from dataclasses import dataclass, field
from typing import Deque, Tuple


def _env_float(name: str, default: float) -> float:
    raw = os.environ.get(name)
    if raw is None or raw == "":
        return default
    try:
        return float(raw)
    except ValueError:
        return default


@dataclass
class Budget:
    time_budget: float = field(default_factory=lambda: _env_float("REDUCER_TIME_BUDGET", 300.0))
    min_throughput: float = field(default_factory=lambda: _env_float("REDUCER_MIN_THROUGHPUT", 0.05))
    stagnation_seconds: float = field(default_factory=lambda: _env_float("REDUCER_STAGNATION_SECONDS", 30.0))
    start_time: float = field(default_factory=time.monotonic)
    _samples: Deque[Tuple[float, int]] = field(default_factory=lambda: deque(maxlen=64))
    _below_since: float | None = None

    def elapsed(self) -> float:
        return time.monotonic() - self.start_time

    def record(self, tokens_remaining: int) -> None:
        """Record a token-count sample at the current time."""
        self._samples.append((time.monotonic(), tokens_remaining))

    def throughput(self) -> float:
        """Tokens pruned per second over the last sample window."""
        if len(self._samples) < 2:
            return float("inf")
        (t0, n0), (t1, n1) = self._samples[0], self._samples[-1]
        dt = t1 - t0
        if dt <= 0:
            return float("inf")
        return max(0.0, (n0 - n1) / dt)

    def exhausted(self) -> bool:
        if self.elapsed() >= self.time_budget:
            return True
        thr = self.throughput()
        now = time.monotonic()
        if thr < self.min_throughput:
            if self._below_since is None:
                self._below_since = now
            elif now - self._below_since >= self.stagnation_seconds:
                return True
        else:
            self._below_since = None
        return False

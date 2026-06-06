"""Reduction driver: loops over passes until a full round makes no progress
or the budget is exhausted.
"""

from __future__ import annotations

from typing import Callable, List

from .budget import Budget
from .cache import CandidateCache
from .oracle import OraclePool
from .passes.base import Oracle, Pass
from .tokens import count_tokens


class _BudgetExhausted(Exception):
    """Raised inside the oracle wrapper to abort a pass early."""


class Driver:
    def __init__(self, passes: List[Pass], pool: OraclePool,
                 budget: Budget | None = None,
                 cache: CandidateCache | None = None) -> None:
        self.passes = passes
        self.pool = pool
        self.budget = budget or Budget()
        self.cache = cache or CandidateCache()
        # Set by reducer.py to capture the best candidate seen so far, so a
        # SIGTERM/SIGINT handler can flush it to disk.
        self.on_progress: Callable[[str], None] | None = None

    def _emit(self, query: str) -> None:
        if self.on_progress is not None:
            try:
                self.on_progress(query)
            except Exception:
                pass

    def _wrap_oracle(self) -> Oracle:
        def check(candidate: str) -> bool:
            if self.budget.exhausted():
                raise _BudgetExhausted()
            cached = self.cache.get(candidate)
            if cached is not None:
                return cached
            verdict = self.pool.check(candidate)
            self.cache.put(candidate, verdict)
            return verdict
        return check

    def _wrap_batch_oracle(self):
        def check_batch(candidates: list[str]) -> list[bool]:
            if self.budget.exhausted():
                raise _BudgetExhausted()
            results: list[bool | None] = [None] * len(candidates)
            to_run: list[tuple[int, str]] = []
            for i, c in enumerate(candidates):
                cached = self.cache.get(c)
                if cached is not None:
                    results[i] = cached
                else:
                    to_run.append((i, c))
            if to_run:
                verdicts = self.pool.check_batch([c for _, c in to_run])
                for (i, c), v in zip(to_run, verdicts):
                    self.cache.put(c, v)
                    results[i] = v
            return [bool(r) for r in results]
        return check_batch

    def run(self, query: str) -> str:
        oracle = self._wrap_oracle()
        # Sanity-check: original must already trigger the bug.
        try:
            if not oracle(query):
                return query
        except _BudgetExhausted:
            return query

        # Inject the batch oracle + progress hook into any pass that wants it.
        batch = self._wrap_batch_oracle()
        for p in self.passes:
            if hasattr(p, "batch_oracle"):
                setattr(p, "batch_oracle", batch)
            if hasattr(p, "on_progress"):
                setattr(p, "on_progress", self._emit)

        current = query
        best_tokens = count_tokens(current)
        self.budget.record(best_tokens)
        self._emit(current)
        try:
            while True:
                round_start = best_tokens
                for p in self.passes:
                    try:
                        reduced = p.reduce(current, oracle)
                    except _BudgetExhausted:
                        return current
                    new_tokens = count_tokens(reduced)
                    if new_tokens < best_tokens:
                        current = reduced
                        best_tokens = new_tokens
                        self.budget.record(best_tokens)
                        self._emit(current)
                if best_tokens >= round_start:
                    break
                if self.budget.exhausted():
                    break
        except _BudgetExhausted:
            pass
        return current

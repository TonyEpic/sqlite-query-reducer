"""Candidate cache — avoid re-running the oracle on the same query twice."""

from __future__ import annotations

import hashlib


class CandidateCache:
    """Maps a candidate query (by hash) to its oracle verdict.

    True  → oracle accepted (bug still triggers).
    False → oracle rejected.
    """

    def __init__(self) -> None:
        self._store: dict[str, bool] = {}
        self.hits = 0
        self.misses = 0

    @staticmethod
    def _key(query: str) -> str:
        return hashlib.sha1(query.encode("utf-8", errors="replace")).hexdigest()

    def get(self, query: str) -> bool | None:
        verdict = self._store.get(self._key(query))
        if verdict is None:
            self.misses += 1
        else:
            self.hits += 1
        return verdict

    def put(self, query: str, verdict: bool) -> None:
        self._store[self._key(query)] = verdict

    def __len__(self) -> int:
        return len(self._store)

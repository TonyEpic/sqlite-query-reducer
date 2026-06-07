"""Coarse statement-level delta debugging pass.

Splits the query into statements by splitting on ``;``, then applies Zeller's
ddmin at the statement level — first trying coarse chunks (n=2), then
progressively finer as the algorithm doubles n on each failure.

This pass runs *before* token-level ddmin because removing whole statements
is structurally safer and faster than token-by-token reduction.
"""

from __future__ import annotations

from typing import Callable, List, Optional

from .base import Oracle
from .token_ddmin import _chunks, _ddmin

BatchOracle = Callable[[List[str]], List[bool]]
ProgressHook = Callable[[str], None]


def _split_statements(query: str) -> List[str]:
    """Split query on ``;`` to obtain individual statements.

    Preserves inter-statement whitespace within each part so that joining
    with ``;`` reconstructs the original formatting.
    """
    parts = query.split(";")
    return parts


def _build_from_statements(
    all_parts: List[str], keep_orig_indices: List[int]
) -> str:
    """Rebuild the query by keeping only parts at the given original indices."""
    kept_set = set(keep_orig_indices)
    kept_parts = [p for i, p in enumerate(all_parts) if i in kept_set]
    return ";".join(kept_parts)


class CoarseReducerPass:
    """Statement-level delta debugging reduction pass.

    Splits the query on ``;``, discards fully whitespace-only parts,
    then runs ddmin over the remaining statement indices.  The driver
    transparently wraps the oracle with a :class:`CandidateCache`, so
    repeated evaluations of the same candidate are cache hits.
    """

    name = "coarse_reducer"

    def __init__(self, batch_oracle: Optional[BatchOracle] = None) -> None:
        self.batch_oracle = batch_oracle
        # Set by the driver so we can emit incremental progress.
        self.on_progress: Optional[ProgressHook] = None

    def reduce(self, query: str, oracle: Oracle) -> str:
        parts = _split_statements(query)

        # Identify parts that contain actual SQL (not just whitespace).
        # We reduce over these; empty/whitespace parts are always dropped.
        live = [(i, p) for i, p in enumerate(parts) if p.strip()]
        if len(live) < 2:
            return query

        live_indices = [i for i, _p in live]
        # live_indices maps 0..len(live)-1 → original part index

        def build(keep: List[int]) -> str:
            # ``keep`` contains indices into the *live* list.
            kept_orig = [live_indices[k] for k in keep]
            return _build_from_statements(parts, kept_orig)

        kept = _ddmin(
            list(range(len(live))),
            build,
            oracle,
            self.batch_oracle,
            self.on_progress,
        )
        return build(kept)

"""Pass protocol.

Every reduction pass exposes ``reduce(query, oracle) -> str``: given a query
and an oracle callable (returns True if the bug still triggers), the pass
returns a possibly-smaller query that still triggers the bug.

For the common "generate-and-test" pattern, subclass ``GenerativePass`` and
implement ``candidates(query)`` to yield variants.
"""

from __future__ import annotations

from typing import Callable, Iterable, Protocol, runtime_checkable

Oracle = Callable[[str], bool]


@runtime_checkable
class Pass(Protocol):
    name: str

    def reduce(self, query: str, oracle: Oracle) -> str:
        """Return a reduced query (possibly equal to ``query`` if no progress)."""
        ...


class GenerativePass:
    """Base for passes that just yield candidates and let the driver test them.

    Subclasses implement ``candidates(query)``. ``reduce`` iterates candidates
    in order, accepts the first that passes the oracle and is strictly smaller,
    then continues from the accepted query until no further candidate works.
    Smaller is measured by raw character length here (cheap); the driver uses
    token count for outer-loop fixpoint detection.
    """

    name = "generative"

    def candidates(self, query: str) -> Iterable[str]:
        raise NotImplementedError

    def reduce(self, query: str, oracle: Oracle) -> str:
        current = query
        progressed = True
        while progressed:
            progressed = False
            for cand in self.candidates(current):
                if len(cand) < len(current) and oracle(cand):
                    current = cand
                    progressed = True
                    break
        return current


class NoOpPass:
    name = "noop"

    def reduce(self, query: str, oracle: Oracle) -> str:
        return query

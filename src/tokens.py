"""Token counting — must match the grader's metric.

The graders count tokens via sqlglot.Tokenizer().tokenize(query). We use the
same call so our reported numbers line up with theirs.
"""

from __future__ import annotations

import sqlglot


_TOKENIZER = sqlglot.Tokenizer()


def count_tokens(query: str) -> int:
    """Return the sqlglot token count for ``query``.

    Falls back to a length-based estimate on tokenizer failure so the reducer
    never crashes on adversarial inputs (q14-style malformed SQL).
    """
    try:
        return len(_TOKENIZER.tokenize(query))
    except Exception:
        # Fallback: rough estimate so progress comparisons still work.
        return max(1, len(query.split()))

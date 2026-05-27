# SQL Query Reducer (AST 2026, Part 2)

Automated reducer for bug-triggering SQL queries against SQLite 3.26.0 / 3.39.4.
Course project for *Automated Software Testing* (UZH, Spring 2026).

## CLI contract

```
reducer --query <path-to-sql-file> --test <path-to-oracle-script>
```

- `--query`: path to the `.sql` file to minimize. The reducer **overwrites this file
  in place** with the final minimized query.
- `--test`: path to a shell script (the oracle).
  - Exit code `0` → bug still triggers → reduction is accepted.
  - Exit code `1` → bug no longer triggers → last change is reverted.
- The oracle reads its candidate either from `./query.sql` in the CWD or from the
  path in `TEST_CASE_LOCATION` if that env var is set. The reducer is responsible
  for writing the candidate to one of those locations before each invocation.
- The reducer must never call `sqlite3` directly — only the oracle runs SQLite.

## Repository layout

```
.
├── Dockerfile          # builds the grading image (installs reducer to /usr/bin/reducer)
├── requirements.txt    # Python dependencies
├── src/
│   └── reducer.py      # reducer implementation (entry point)
├── queries/            # 20 benchmark inputs (queryN/{original_test.sql,test.sh,oracle.txt})
└── README.md
```

## Build & run (Docker)

```bash
docker build -t reducer .
docker run --rm -v "$PWD/queries:/queries" reducer \
    reducer --query /queries/query1/original_test.sql \
            --test  /queries/query1/test.sh
```

The grading harness mounts the benchmarks into the container, so the image must
not bake them in.

## Local run (without Docker)

```bash
pip install -r requirements.txt
python src/reducer.py --query queries/query1/original_test.sql \
                     --test  queries/query1/test.sh
```

You will need `sqlite3-3.26.0` and `sqlite3-3.39.4` on `PATH` for the oracle
scripts to work locally (they are pre-installed in the `theosotr/sqlite3-reducer`
image).

## Evaluation

- **Quality (60 %)**: percentage reduction in `sqlglot` token count.
- **Speed (30 %)**: wall-clock time per benchmark.
- **Report (10 %)**: `report.pdf` describing the approach and results.

Token counter used by the graders (use the same one in our own evaluation):

```python
import sys, sqlglot
with open(sys.argv[1]) as f:
    query = f.read()
print(len(sqlglot.Tokenizer().tokenize(query)))
```

## Restrictions

- No reuse of existing reducers (Perses, C-Reduce, Picire) as the submission.
- Parser libraries (sqlglot tokenizer / pretty-printer, sqlparse, ANTLR visitors)
  are allowed. Query optimizers / rewriters (e.g. `sqlglot.optimizer`) are not.

## Deadline

June 11, 17:00.

#! /bin/bash

if [ -z "$TEST_CASE_LOCATION" ]; then
    SQL_FILE="query.sql"
else
    SQL_FILE="$TEST_CASE_LOCATION"
fi

if sqlite3-3.26.0 < $SQL_FILE 2>&1 | grep -q "database disk image is malformed"; then
  exit 0
else
  exit 1
fi

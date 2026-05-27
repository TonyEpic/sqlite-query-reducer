#! /bin/bash

if [ -z "$TEST_CASE_LOCATION" ]; then
    SQL_FILE="query.sql"
else
    SQL_FILE="$TEST_CASE_LOCATION"
fi


if sqlite3-3.39.4 < $SQL_FILE 2>&1 | grep -q "NOT NULL constraint failed"; then
  if sqlite3-3.26.0 < $SQL_FILE 2>&1 | grep -q "NOT NULL constraint failed"; then
    exit 1
  else
    exit 0
  fi
fi
exit 1

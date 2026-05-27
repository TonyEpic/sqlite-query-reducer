#! /bin/bash

if [ -z "$TEST_CASE_LOCATION" ]; then
    SQL_FILE="query.sql"
else
    SQL_FILE="$TEST_CASE_LOCATION"
fi

sqlite3-3.26.0 < $SQL_FILE > /dev/null 2>&1
if [ $? -eq 139 ]; then
  exit 0
else
  exit 1
fi

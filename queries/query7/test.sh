#! /bin/bash

if [ -z "$TEST_CASE_LOCATION" ]; then
    SQL_FILE="query.sql"
else
    SQL_FILE="$TEST_CASE_LOCATION"
fi

out1=$(sqlite3-3.26.0 < $SQL_FILE | sort)
ret1=$?
out2=$(sqlite3-3.39.4 < $SQL_FILE | sort)
ret2=$?

if [ "$ret1" = "$ret2" ]; then
  test "$out1" = "$out2"
  exit $(( ! $?  ))
else
  exit 1
fi

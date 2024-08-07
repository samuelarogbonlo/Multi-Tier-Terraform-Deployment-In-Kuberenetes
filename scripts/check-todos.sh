#!/bin/bash

# WARNING: You don't need to edit this file!

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

. "${SCRIPTPATH}/_library.sh"

set -e

ROOT_DIR="${SCRIPTPATH}/../"
MODULE1="${SCRIPTPATH}/../modules/infrastructure"
MODULE2="${SCRIPTPATH}/../modules/deploy"

function check_todos_missing_in_file() {
  FILENAME="$1"
  LINE="TODO:"
  grep -q "$LINE" "$FILENAME" && c=0 || c=1
  [[ $c == 0 ]] && log_fail "Found TODOs in ${FILENAME}" || log_pass "No TODOs found in ${FILENAME}"
}

DIR="${MODULE1}"
for f in cluster.tf outputs.tf providers.tf s3.tf variables.tf README.md; do
  log_test "Check that todos are addressed in ${DIR}/${f}"
  check_todos_missing_in_file "${DIR}/${f}"
done

DIR="${MODULE2}"
for f in nginx.tf outputs.tf s3_app.tf variables.tf README.md; do
  log_test "Check that todos are addressed in ${DIR}/${f}"
  check_todos_missing_in_file "${DIR}/${f}"
done

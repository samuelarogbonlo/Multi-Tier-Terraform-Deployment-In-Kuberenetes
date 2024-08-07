#!/bin/bash

# WARNING: You don't need to edit this file!

# This script checks that the following tools are installed:
# - Docker
# - kind
# - kubectl
# - localstack

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

. "${SCRIPTPATH}/_library.sh"

set -eu

SUCCESS="true"

function mark_fail() {
  SUCCESS="false"
}

function check_command() {
  CMD="$1"
  PRG=$(echo $CMD | cut -d " " -f1)
  log_test "Checking that $PRG is installed"
  if ! $CMD &> /dev/null
  then
    log_fail "$PRG not installed or not running"
    return 1
  else
    log_pass "$PRG is installed"
  fi
}

check_command docker && log_info "$(docker --version)" || mark_fail
docker_running=$(docker info >/dev/null 2>&1 && echo "true" || echo "false")
if [[ $docker_running == "true" ]]; then
  log_info "Docker daemon is runnning"
else
  log_fail "Docker daemon is not running"
  mark_fail
fi

check_command kubectl && log_info "$(kubectl version --client=true)" || mark_fail
check_command kind && log_info "$(kind --version)" || mark_fail
check_command "curl -V" && log_info "$(curl --version)" || mark_fail
check_command "jq --version" && log_info "$(jq --version)" || mark_fail

log_test "Checking that Localstack Docker container is running"
CONTAINER_NAME="camunda_localstack"
CONTAINER_ID=$(docker ps -aqf "name=$CONTAINER_NAME")
if [[ "$(docker inspect -f {{.State.Health.Status}} $CONTAINER_ID)" == "healthy" ]] ; then
  log_pass "Localstack Docker container is running"
else
  log_fail "Localstack Docker container is not running. Did you run 'make localstack-start'?"
fi

[[ $SUCCESS != "true" ]] && exit 1 || exit 0

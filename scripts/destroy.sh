#!/bin/bash

# WARNING: You don't need to edit this file!

# Deletes the resources in the workspaces

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

. "${SCRIPTPATH}/_library.sh"

set -e

function destroy() {
  workspace="$1"
  log_test "Destroying worspace ${workspace}"
  cd "${SCRIPTPATH}/../${workspace}"
  log_info "Destroying workspace ${workspace}"
  terraform destroy -auto-approve && log_pass "Workspace ${workspace} destroyed successfully" || log_fail "Workspace ${workspace} could not be destroyed"
  rm -f test-cluster-config
}

DELETE=$(yes_no "Do you want to delete all the Terraform resources (kind cluster and the resources in it)?")

if [[ "$DELETE" == "y" ]]; then
  destroy "02-app-deploy"
  destroy "01-cluster-create"
else
  log_info "Skipping workspaces deletion"
fi

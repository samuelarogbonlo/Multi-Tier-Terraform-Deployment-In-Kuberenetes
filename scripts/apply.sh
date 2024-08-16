

# Creates the resources in the workspaces

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

. "${SCRIPTPATH}/_library.sh"

set -e

function apply_workspace() {
  workspace="$1"
  log_test "Applying worspace ${workspace}"
  cd "${SCRIPTPATH}/../${workspace}"
  log_info "Applying workspace ${workspace}"
  terraform init -upgrade
  terraform apply -auto-approve && log_pass "Workspace ${workspace} applied successfully" || log_fail "Workspace ${workspace} could not be applied"
}

workspace="$1"

if [ -z "$workspace" ]; then
  apply_workspace "cluster
  apply_workspace "app-deployment"
else
  apply_workspace "$workspace"
fi

#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "OCI offline installation"

echo "Prepare account"
source ${DIR}/ocp-account-prep.oci-offline.sh

echo "Create infra"
source ${DIR}/ocp-infra-create.oci-offline.sh

echo "Create cluster"
source ${DIR}/ocp-cluster-create.oci-offline.sh

echo "Destroy cluster"
source ${DIR}/ocp-cluster-create.oci-offline.sh

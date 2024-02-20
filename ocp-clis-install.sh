#!/bin/bash
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#BASE_URL="https://openshift-release-artifacts.apps.ci.l2s4.p1.openshiftapps.com"
#VERSION_TAG="4.15.0-rc.2"

BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest"
VERSION_TAG="4.14.11" 

mkdir -p "${DIR}/bin"

# Clean
rm -f "${DIR}/bin/openshift-install"
rm -f "${DIR}/bin/ccoctl"
rm -f "${DIR}/bin/oc"
rm -f "${DIR}/bin/kubectl"


# Download openshift-install
FILE_INSTALLER="openshift-install-linux-${VERSION_TAG}.tar.gz"
#URL_INSTALLER="${BASE_URL}/${VERSION_TAG}/${FILE_INSTALLER}"
URL_INSTALLER="${BASE_URL}/${FILE_INSTALLER}"
TEMP_INSTALLER="/tmp/openshift-install"


mkdir -p "${TEMP_INSTALLER}"
curl -Ls "${URL_INSTALLER}" -o "${TEMP_INSTALLER}/${FILE_INSTALLER}"
tar zxvf "${TEMP_INSTALLER}/${FILE_INSTALLER}" -C "${TEMP_INSTALLER}" 
mv  "${TEMP_INSTALLER}/openshift-install" "${DIR}"    
rm "${TEMP_INSTALLER}/${FILE_INSTALLER}" 
"${DIR}/openshift-install" version 


# ccoctl

FILE_CCOCTL="ccoctl-linux-${VERSION_TAG}.tar.gz"
# URL_CCOCTL="${BASE_URL}/${VERSION_TAG}/${FILE_CCOCTL}"
URL_CCOCTL="${BASE_URL}/${FILE_CCOCTL}"
TEMP_CCOCTL="/tmp/ccoctl"

mkdir -p "${TEMP_CCOCTL}"
curl -Ls "${URL_CCOCTL}" -o "${TEMP_CCOCTL}/${FILE_CCOCTL}"
tar zxvf "${TEMP_CCOCTL}/${FILE_CCOCTL}" -C "${TEMP_CCOCTL}" 
mv  "${TEMP_CCOCTL}/ccoctl" "${DIR}"    
rm "${TEMP_CCOCTL}/${FILE_CCOCTL}" 
"${DIR}/ccoctl" help 

# oc

FILE_INSTALLER="openshift-client-linux-${VERSION_TAG}.tar.gz"
# URL_INSTALLER="${BASE_URL}/${VERSION_TAG}/${FILE_INSTALLER}"
URL_INSTALLER="${BASE_URL}/${FILE_INSTALLER}"
TEMP_INSTALLER="/tmp/openshift-client"

mkdir -p "${TEMP_INSTALLER}"
curl -Ls "${URL_INSTALLER}" -o "${TEMP_INSTALLER}/${FILE_INSTALLER}"
tar zxvf "${TEMP_INSTALLER}/${FILE_INSTALLER}" -C "${TEMP_INSTALLER}" 
mv  "${TEMP_INSTALLER}/oc" "${DIR}"
mv  "${TEMP_INSTALLER}/kubectl" "${DIR}"    
rm "${TEMP_INSTALLER}/${FILE_INSTALLER}" 
"${DIR}/oc" version client

echo "System links to PATH"
sudo ln -sf "${DIR}/kubectl" "/usr/local/bin/kubectl"
sudo ln -sf "${DIR}/oc" "/usr/local/bin/oc"
sudo ln -sf "${DIR}/openshift-install" "/usr/local/bin/openshift-install" 
sudo ln -sf "${DIR}/ccoctl" "/usr/local/bin/ccoctl" 

oc version client

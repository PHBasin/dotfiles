#!/usr/bin/env bash

# If there's already a kubeconfig file in ~/.kube/config it will import that too and all the contexts
DEFAULT_KUBECONFIG_FILE="${HOME}/.kube/config"
if test -f "${DEFAULT_KUBECONFIG_FILE}"
then
  export KUBECONFIG="${DEFAULT_KUBECONFIG_FILE}"
fi

# Your additional kubeconfig files should be inside ~/.kube/config-files
KUBECONFIG_FOLDER="$HOME/.kube/config-files"
mkdir -p "${KUBECONFIG_FOLDER}"
for KUBECONFIG_FILE in `find "${KUBECONFIG_FOLDER}" -type f -name "*.yml" -o -name "*.yaml"`
do
    export KUBECONFIG="${KUBECONFIG}:${KUBECONFIG_FILE}"
done

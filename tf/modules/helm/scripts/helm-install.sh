#!/bin/bash

# Usage:
# ./helm-install.sh <VAULT_OR_RRIV> <ENV>
set -euo pipefail

CLUSTER=$1
ENV=$2

# Function to retry helm commands with exponential backoff
retry_helm() {
    local max_attempts=3
    local delay=5
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        echo "Attempt $attempt of $max_attempts: $*"
        if "$@"; then
            echo "Success on attempt $attempt"
            return 0
        else
            if [ $attempt -eq $max_attempts ]; then
                echo "Failed after $max_attempts attempts"
                return 1
            fi
            echo "Attempt $attempt failed. Retrying in ${delay}s..."
            sleep $delay
            delay=$((delay * 2))  # Exponential backoff
            attempt=$((attempt + 1))
        fi
    done
}

helm repo add jetstack https://charts.jetstack.io
helm repo add external-secrets https://charts.external-secrets.io
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

retry_helm helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --set startupapicheck.enabled=false \
  --timeout 600s \
  --wait \
  --kube-context do-sfo2-${CLUSTER}-${ENV}

retry_helm helm upgrade --install ${CLUSTER}-external-secrets external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set crds.enabled=true \
    --timeout 600s \
    --wait \
    --kube-context do-sfo2-${CLUSTER}-${ENV}

retry_helm helm upgrade --install vault-secrets-operator hashicorp/vault-secrets-operator \
    --namespace vault-secrets-operator \
    --create-namespace \
    --set crds.enabled=true \
    --timeout 600s \
    --wait \
    --kube-context do-sfo2-${CLUSTER}-${ENV}

# Install Emissary only for rriv clusters
if [ "${CLUSTER}" = "rriv" ]; then
    echo "Installing Emissary for rriv cluster..."
    
    # Add the Emissary repo
    helm repo add datawire https://app.getambassador.io
    helm repo update
    
    # Create namespace and apply CRDs with retry logic
    retry_helm kubectl create namespace emissary --context do-sfo2-${CLUSTER}-${ENV} || true
    retry_helm kubectl apply -f https://app.getambassador.io/yaml/emissary/3.9.1/emissary-crds.yaml --context do-sfo2-${CLUSTER}-${ENV}
fi
#!/bin/bash

# ./00-helm-install.sh <VAULT_OR_RRIV> <ENV>
set -euo pipefail

CLUSTER=$1
ENV=$2

helm repo add jetstack https://charts.jetstack.io
helm repo add external-secrets https://charts.external-secrets.io
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --kube-context do-sfo2-${CLUSTER}-${ENV}

helm upgrade --install ${CLUSTER}-external-secrets external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set crds.enabled=true \
    --kube-context do-sfo2-${CLUSTER}-${ENV}

helm upgrade --install vault-secrets-operator hashicorp/vault-secrets-operator \
    --namespace vault-secrets-operator \
    --create-namespace \
    --set crds.enabled=true \
    --kube-context do-sfo2-${CLUSTER}-${ENV}
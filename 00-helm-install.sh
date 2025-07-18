#!/bin/bash
set -euo pipefail

helm repo add jetstack https://charts.jetstack.io
helm repo add external-secrets https://charts.external-secrets.io
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true

helm install external-secrets external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set crds.enabled=true

helm install vault-secrets-operator hashicorp/vault-secrets-operator \
    --namespace vault-secrets-operator \
    --create-namespace \
    --set crds.enabled=true
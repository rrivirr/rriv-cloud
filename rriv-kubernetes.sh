#!/bin/bash
set -euo pipefail

# install the CRDs
git clone https://github.com/external-secrets/external-secrets.git
cd external-secrets
git checkout v0.17.0
# kubectl apply -f config/crds/bases
# rm -rf external-secrets
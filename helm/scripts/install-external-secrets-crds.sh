#!/bin/bash
set -e

# Check if CRDs are already installed and established
if kubectl get crd clustersecretstores.external-secrets.io >/dev/null 2>&1 && \
   kubectl get crd externalsecrets.external-secrets.io >/dev/null 2>&1 && \
   kubectl get crd secretstores.external-secrets.io >/dev/null 2>&1; then
  echo "External-secrets CRDs are already installed and available"
  kubectl wait --for condition=established --timeout=10s crd/clustersecretstores.external-secrets.io || true
  kubectl wait --for condition=established --timeout=10s crd/externalsecrets.external-secrets.io || true
  kubectl wait --for condition=established --timeout=10s crd/secretstores.external-secrets.io || true
  echo "CRDs are established, skipping installation"
  exit 0
fi

EXTERNAL_SECRETS_VERSION=${1:-"v0.17.0"}
echo "Installing external-secrets CRDs version $EXTERNAL_SECRETS_VERSION"

# Create temp directory for cloning
TEMP_DIR="/tmp/external-secrets-$EXTERNAL_SECRETS_VERSION"

# Clean up any existing directory
rm -rf "$TEMP_DIR"

# Clone the external-secrets repository
git clone https://github.com/external-secrets/external-secrets.git "$TEMP_DIR"

# Navigate to the repo and checkout the specific version
cd "$TEMP_DIR"
git fetch --all --tags
git checkout "$EXTERNAL_SECRETS_VERSION"

# Apply the CRDs
if [ -d "config/crds/bases" ]; then
  find config/crds/bases -name "*.yaml" -not -name "kustomization.yaml" -exec kubectl apply -f {} \;
fi

# Wait for CRDs to be established
echo "Waiting for CRDs to be established..."
kubectl wait --for condition=established --timeout=120s crd/clustersecretstores.external-secrets.io || echo "ClusterSecretStore CRD not found, continuing..."
kubectl wait --for condition=established --timeout=120s crd/externalsecrets.external-secrets.io || echo "ExternalSecret CRD not found, continuing..."
kubectl wait --for condition=established --timeout=120s crd/secretstores.external-secrets.io || echo "SecretStore CRD not found, continuing..."

# Additional wait to ensure API server has fully registered the CRDs
echo "Waiting additional 10 seconds for API server registration..."
sleep 10

# Verify CRDs are available
echo "Verifying CRDs are available:"
kubectl get crd | grep external-secrets.io || echo "No external-secrets CRDs found"

# Clean up
rm -rf "$TEMP_DIR"

echo "External-secrets CRDs installation completed"

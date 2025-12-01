#!/usr/bin/env bash

set -euo pipefail

ENV="${1:-dev}"  # default to "dev" if not passed

# Set VAULT_ADDR based on environment
if [ "$ENV" = "prod" ]; then
  VAULT_ADDR="https://vault.rriv.org:8200"
else
  VAULT_ADDR="https://vault.${ENV}.rriv.org:8200"
fi

# Use this export so vault CLI works
export VAULT_ADDR
export VAULT_SKIP_VERIFY=true

echo "Vault address: $VAULT_ADDR"
echo "Using root token from secure storage (e.g., Proton Pass)..."

# Prompt for Vault root token (you shouldn't hardcode this)
read -s -p "Enter your Vault ROOT token: " VAULT_ROOT_TOKEN
echo ""

# Authenticate with Vault using root token
VAULT_TOKEN=$VAULT_ROOT_TOKEN vault login "$VAULT_ROOT_TOKEN" > /dev/null

# Ensure the terraform-admin policy exists
vault policy write terraform-admin - <<EOF
# Allow managing policies
path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Auth backend management
path "sys/auth" {
  capabilities = ["read"]
}
path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Mount info
path "sys/mounts" {
  capabilities = ["read"]
}
path "sys/mounts/*" {
  capabilities = ["read"]
}

# Kubernetes auth backend management
path "auth/kubernetes/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Userpass if needed
path "auth/userpass/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Token creation
path "auth/token/create" {
  capabilities = ["create", "update", "sudo"]
}
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Identity (groups, entities)
path "identity/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Secrets
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

# Create temporary token
TEMP_TOKEN=$(vault token create \
  -policy=terraform-admin \
  -period=24h \
  -format=json | jq -r .auth.client_token)

echo ""
echo "✅ Temporary Terraform token created:"
echo "$TEMP_TOKEN"
echo ""
echo "💡 Copy this and use it in your secrets.auto.tfvars or environment:"
echo "  export TF_VAR_vault_token=$TEMP_TOKEN"

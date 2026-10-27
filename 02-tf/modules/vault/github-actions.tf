# GitHub Actions login (GitHub's OIDC tokens), for the rriv-firmware release
# workflow to read the firmware signing key. Only created where
# var.firmware_signing is set (prod): one signing key signs every release.
#
# The key itself isn't managed here (it would land in Terraform state). Write
# it once with `vault kv put secret/firmware-signing private_key=<64 hex digits>`
# (see board/keys/README.md in rriv-firmware).

locals {
  github_oidc_issuer = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend" "github_actions" {
  count = var.firmware_signing ? 1 : 0

  path               = "github-actions"
  type               = "jwt"
  description        = "GitHub Actions OIDC tokens"
  oidc_discovery_url = local.github_oidc_issuer
  bound_issuer       = local.github_oidc_issuer
}

resource "vault_policy" "firmware_signing_policy" {
  count = var.firmware_signing ? 1 : 0

  name   = "firmware-signing"
  policy = <<EOT
path "secret/data/firmware-signing" {
  capabilities = ["read"]
}
EOT
}

# Only jobs in the repo's `firmware-release` GitHub environment get a token, so
# the environment's protection rules (branches, reviewers) gate the key.
resource "vault_jwt_auth_backend_role" "firmware_release" {
  count = var.firmware_signing ? 1 : 0

  backend         = vault_jwt_auth_backend.github_actions[0].path
  role_name       = "firmware-release"
  role_type       = "jwt"
  user_claim      = "sub"
  bound_audiences = [var.github_actions_vault_audience]
  bound_claims = {
    sub = "repo:${var.firmware_repo}:environment:firmware-release"
  }
  token_policies = [vault_policy.firmware_signing_policy[0].name]
  token_ttl      = 600
  token_max_ttl  = 900
}

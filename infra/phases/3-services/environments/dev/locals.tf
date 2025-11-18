locals {
  env = "dev"
  do_region = "sfo2"
  vpc_octet = 10
  vault_iam_user_access_key_secret_name = "rriv-${local.env}-vault-user-access-keys"
  vault_kms_key_alias = "alias/rriv-${local.env}-vault"
  vault_token = var.vault_token
  keycloak_client_secret = var.keycloak_client_secret
}
# Manually-entered secrets
data "vault_kv_secret_v2" "keycloak_smtp_creds" {
  mount = vault_mount.app_secrets.path
  name  = "${var.env}-keycloak-smtp-creds"
}

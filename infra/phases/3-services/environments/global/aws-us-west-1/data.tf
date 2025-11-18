# These depend on 2-app-platform being built first
data "aws_secretsmanager_secret" "keycloak_bootstrap_creds" {
  name = local.keycloak_bootstrap_creds_secret_name
}

data "aws_secretsmanager_secret_version" "keycloak_bootstrap_creds" {
  secret_id = data.aws_secretsmanager_secret.keycloak_bootstrap_creds.id
}

data "aws_secretsmanager_secret" "keycloak_smtp_creds" {
  name = local.keycloak_smtp_creds_secret_name
}

data "aws_secretsmanager_secret_version" "keycloak_smtp_creds" {
  secret_id = data.aws_secretsmanager_secret.keycloak_smtp_creds.id
}
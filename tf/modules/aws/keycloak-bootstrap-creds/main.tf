resource "aws_secretsmanager_secret" "keycloak_bootstrap_admin_creds" {
  name        = "rriv-${var.env}-keycloak-bootstrap-admin-creds"
  description = "Username and password for Keycloak bootstrap admin user"
}

resource "aws_secretsmanager_secret_version" "keycloak_bootstrap_admin_creds" {
  secret_id     = aws_secretsmanager_secret.keycloak_bootstrap_admin_creds.id
  secret_string = jsonencode({
    username = random_pet.keycloak_bootstrap_admin_username.id
    password = random_password.keycloak_bootstrap_admin_password.result
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "random_pet" "keycloak_bootstrap_admin_username" {
  length = 2
}

resource "random_password" "keycloak_bootstrap_admin_password" {
  length  = 20
  special = true
  upper   = true
  lower   = true
}
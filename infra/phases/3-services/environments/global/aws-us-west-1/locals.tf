locals {
  keycloak_bootstrap_creds_secret_name = "rriv-${var.env}-keycloak-bootstrap-creds"
  keycloak_smtp_creds_secret_name = "rriv-${var.env}-keycloak-smtp-creds"
}
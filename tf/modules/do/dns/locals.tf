locals {
  vault_subdomain = var.env == "production" ? "vault" : "vault-${var.env}"
  chirpstack_subdomain = var.env == "production" ? "chirp" : "chirp-${var.env}"
  chirpstack_console_subdomain = var.env == "production" ? "console.chirp" : "console.chirp-${var.env}"
  keycloak_subdomain = var.env == "production" ? "auth" : "auth-${var.env}"
  app_subdomain = var.env == "production" ? "app" : "app-${var.env}"
}
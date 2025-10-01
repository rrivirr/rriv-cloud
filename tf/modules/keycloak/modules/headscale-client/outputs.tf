output "headscale_oidc_client_secret" {
  description = "Keycloak client secret for Headscale"
  value       = keycloak_openid_client.headscale.client_secret
  sensitive   = true
}

output "headscale_oidc_client_id" {
  description = "Keycloak client ID for Headscale"
  value       = keycloak_openid_client.headscale.client_id
}
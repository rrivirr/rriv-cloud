output "headscale_oidc_client_id" {
  description = "Keycloak client ID for Headscale"
  value       = try(module.headscale_openid_client[0].headscale_oidc_client_id, null)
}

output "headscale_oidc_client_secret" {
  description = "Keycloak client secret for Headscale"
  value       = try(module.headscale_openid_client[0].headscale_oidc_client_secret, null)
  sensitive   = true
}

output "headscale_oidc_client_id" {
  description = "Keycloak client ID for Headscale"
  value       = try(module.headscale_openid_client[0].headscale_oidc_client_id, null)
}

output "headscale_oidc_client_secret" {
  description = "Keycloak client secret for Headscale"
  value       = try(module.headscale_openid_client[0].headscale_oidc_client_secret, null)
  sensitive   = true
}

output "auth_api_oidc_client_secret" {
  description = "Keycloak client secret for auth-api"
  value       = try(keycloak_openid_client.auth_api.client_secret, null)
  sensitive   = true
}

output "rriv_api_oidc_client_secret" {
  description = "Keycloak client secret for rriv-api"
  value       = try(keycloak_openid_client.rriv_api.client_secret, null)
  sensitive   = true
}

output "data_api_oidc_client_secret" {
  description = "Keycloak client secret for data-api"
  value       = try(keycloak_openid_client.data_api.client_secret, null)
  sensitive   = true
}
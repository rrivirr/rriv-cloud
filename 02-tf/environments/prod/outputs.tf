# output "PROD_GITHUB_ACTIONS_AWS_ROLE_ARN" {
#   value       = "${module.prod_aws_us-west-1_github_actions.github_actions_role_arn} # goes in Github org settings variables"
#   description = "ARN of the GitHub Actions IAM role"
# }

output "vault_k8s_cluster_kubeconfig" {
  value       = module.prod_do_sfo2_k8s_vault_cluster.cluster_kubeconfig
  sensitive   = true
  description = "Kubeconfig for the Vault Kubernetes cluster"
}

output "KUBECONFIG" {
  value       = "${module.prod_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path}:${module.prod_do_sfo2_k8s_rriv_cluster.cluster_kubeconfig_path} # goes in .zshrc or .bashrc"
  description = "$KUBECONFIG environment variable for accessing both Vault and rriv Kubernetes clusters"
}

output "rriv_app_pool_connection_string" {
  value       = module.prod_do_sfo2_postgresdb.rriv_app_pool_connection_string
  sensitive   = true
  description = "Connection string for the ChirpStack application database pool"
}

output "rriv_app_direct_connection_string" {
  value       = module.prod_do_sfo2_postgresdb.rriv_app_direct_connection_string
  sensitive   = true
  description = "Direct connection string for the ChirpStack application database"
}

output "PROTONPASS_vault_kat_password" {
  value       = module.prod_vault_sfo2.kat_password
  sensitive   = true
  description = "Password for the kat user in Vault"
}

output "PROTONPASS_vault_zaven_password" {
  value       = module.prod_vault_sfo2.zaven_password
  sensitive   = true
  description = "Password for the zaven user in Vault"
}

output "PROTONPASS_vault_daniel_password" {
  value       = module.prod_vault_sfo2.daniel_password
  sensitive   = true
  description = "Password for the daniel user in Vault"
}

output "vault_auth_ca_cert" {
  value       = module.prod_k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  sensitive   = true
  description = "Vault authentication CA certificate"
}

output "postgresql_ca_cert" {
  value       = module.prod_do_sfo2_postgresdb.postgresql_ca_cert
  sensitive   = true
  description = "PostgreSQL CA certificate for SSL connections"
}

output "headscale_oidc_client_id" {
  value       = module.prod_keycloak_sfo2.headscale_oidc_client_id
  description = "Client ID for the Headscale service"
}

# Enter this manually into Vault since Keycloak has to be applied first
output "headscale_oidc_client_secret" {
  value       = module.prod_keycloak_sfo2.headscale_oidc_client_secret
  sensitive   = true
  description = "Client secret for the Headscale service"
}

# output "do_api_key_secret_arn" {
#   value = module.prod_aws_us-west-1_do_api_key.secret_github_actions_do_api_key_arn
#   description = "ARN of the Secrets Manager secret containing the DigitalOcean API key for GitHub Actions"
# }

output "do_dns_api_token" {
  value       = module.prod_k8s_sfo2_vault_cluster_secrets.do_dns_api_token
  sensitive   = true
  description = "DNS API token for DigitalOcean"
}

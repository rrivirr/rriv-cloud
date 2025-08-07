# output vpn_droplet_ip {
#   value       = module.dev_do_sfo2_vpn.droplet_ip
#   description = "IP address of the Tailscale exit node droplet in SFO2"
# }

output "DEV_GITHUB_ACTIONS_AWS_ROLE_ARN" {
  value       = "${module.dev_aws_us-west-1_github_actions.github_actions_role_arn} # goes in Github org settings variables"
  description = "ARN of the GitHub Actions IAM role"
}

output "vault_k8s_cluster_kubeconfig" {
  value       = module.dev_do_sfo2_k8s_vault_cluster.cluster_kubeconfig
  sensitive   = true
  description = "Kubeconfig for the Vault Kubernetes cluster"
}

output "KUBECONFIG" {
  value       = "${module.dev_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path}:${module.dev_do_sfo2_k8s_rriv_cluster.cluster_kubeconfig_path} # goes in .zshrc or .bashrc"
  description = "$KUBECONFIG environment variable for accessing both Vault and rriv Kubernetes clusters"
}

output "rriv_app_pool_connection_string" {
  value       = module.dev_do_sfo2_postgresdb.rriv_app_pool_connection_string
  sensitive   = true
  description = "Connection string for the ChirpStack application database pool"
}

output "rriv_app_direct_connection_string" {
  value       = module.dev_do_sfo2_postgresdb.rriv_app_direct_connection_string
  sensitive   = true
  description = "Direct connection string for the ChirpStack application database"
}

output "PROTONPASS_vault_kat_password" {
  value       = module.dev_vault_sfo2.kat_password
  sensitive   = true
  description = "Password for the kat user in Vault"
}

output "PROTONPASS_vault_zaven_password" {
  value       = module.dev_vault_sfo2.zaven_password
  sensitive   = true
  description = "Password for the zaven user in Vault"
}

output "vault_auth_ca_cert" {
  value       = module.dev_k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  sensitive   = true
  description = "Vault authentication CA certificate"
}

output "postgresql_ca_cert" {
  value       = module.dev_do_sfo2_postgresdb.postgresql_ca_cert
  sensitive   = true
  description = "PostgreSQL CA certificate for SSL connections"
}
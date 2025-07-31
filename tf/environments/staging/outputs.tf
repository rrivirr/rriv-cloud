# output vpn_droplet_ip {
#   value       = module.staging_do_sfo2_vpn.droplet_ip
#   description = "IP address of the Tailscale exit node droplet in SFO2"
# }

output "vault_k8s_cluster_kubeconfig" {
  value       = module.staging_do_sfo2_k8s_vault_cluster.cluster_kubeconfig
  sensitive   = true
  description = "Kubeconfig for the Vault Kubernetes cluster"
}

output "vault_k8s_cluster_kubeconfig_path" {
  value       = module.staging_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path
  description = "Path to the kubeconfig file for the Vault Kubernetes cluster"
}

output "rriv_app_pool_connection_string" {
  value       = module.staging_do_sfo2_postgresdb.rriv_app_pool_connection_string
  sensitive   = true
  description = "Connection string for the ChirpStack application database pool"
}

output "rriv_app_direct_connection_string" {
  value       = module.staging_do_sfo2_postgresdb.rriv_app_direct_connection_string
  sensitive   = true
  description = "Direct connection string for the ChirpStack application database"
}

output "vault_kat_password" {
  value       = module.staging_vault_sfo2.kat_password
  sensitive   = true
  description = "Password for the kat user in Vault"
}

output "vault_zaven_password" {
  value       = module.staging_vault_sfo2.zaven_password
  sensitive   = true
  description = "Password for the zaven user in Vault"
}

output "vault_auth_ca_cert" {
  value       = module.staging_k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  sensitive   = true
  description = "Vault authentication CA certificate"
}

output "postgresql_ca_cert" {
  value       = module.staging_do_sfo2_postgresdb.postgresql_ca_cert
  sensitive   = true
  description = "PostgreSQL CA certificate for SSL connections"
}
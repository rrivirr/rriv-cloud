# output "vault_kms_key_id" {
#   value       = module.dev_aws_us-west-1_vault.vault_kms_key_id
#   description = "The ID of the KMS key used by Vault"
# }

# output "vault_iam_user_access_key_id" {
#   value       = module.dev_aws_us-west-1_vault.vault_iam_user_access_key_id
#   description = "The access key ID for the Vault IAM user"
# }

# output "vault_k8s_cluster_kubeconfig" {
#   value       = module.dev_do_sfo2_k8s_vault_cluster.cluster_kubeconfig
#   sensitive   = true
#   description = "Kubeconfig for the Vault Kubernetes cluster"
# }

# output "vault_k8s_cluster_kubeconfig_path" {
#   value       = module.dev_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path
#   description = "Path to the kubeconfig file for the Vault Kubernetes cluster"
# }

# output "rriv_app_connection_string" {
#   value       = module.dev_do_sfo2_postgresdb.rriv_app_connection_string
#   sensitive   = true
#   description = "Connection string for the ChirpStack application database"
# }

# output "vault_kat_password" {
#   value       = module.dev_vault_sfo2.kat_password
#   sensitive   = true
#   description = "Password for the kat user in Vault"
# }
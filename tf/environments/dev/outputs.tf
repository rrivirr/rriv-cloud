output vpn_droplet_ip {
  value       = module.dev_do_sfo2_vpn.droplet_ip
  description = "IP address of the Tailscale exit node droplet in SFO2"
}

output "vault_kms_key_id" {
  value       = module.dev_aws_us-west-1_vault.vault_kms_key_id
  description = "The ID of the KMS key used by Vault"
}

output "vault_iam_user_access_key_id" {
  value       = module.dev_aws_us-west-1_vault.vault_iam_user_access_key_id
  description = "The access key ID for the Vault IAM user"
}

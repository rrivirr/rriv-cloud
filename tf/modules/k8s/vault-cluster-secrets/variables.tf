variable "env" {
  description = "The environment for the Kubernetes cluster"
  type        = string
}

# variable "aws_access_key_id" {
#   description = "The AWS access key ID for the Vault IAM user"
#   type        = string
#   sensitive   = true
# }
# variable "aws_secret_access_key" {
#   description = "The AWS secret access key for the Vault IAM user"
#   type        = string
#   sensitive   = true
# }
# variable "vault_kms_key_id" {
#   description = "The KMS key ID of the root key used to seal/unseal Vault"
#   type        = string
#   sensitive   = true
# }

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "do_token_rriv_cert_manager" {
  description = "DigitalOcean API token scoped for domain read/update only. Used by cert-manager for DNS challenges"
  type        = string
  sensitive   = true
}

variable "vault_iam_user_access_key_secret_name" {
  description = "The name of the AWS Secrets Manager secret that stores the Vault IAM user access keys"
  type        = string
}

variable "vault_kms_key_alias" {
  description = "The alias of the KMS key used for Vault"
  type        = string
}

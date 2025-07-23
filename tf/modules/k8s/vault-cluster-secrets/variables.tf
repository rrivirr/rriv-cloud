variable "env" {
  description = "The environment for the Kubernetes cluster"
  type        = string
}

variable "aws_access_key_id" {
  description = "The AWS access key ID for the Vault IAM user"
  type        = string
  sensitive   = true
}
variable "aws_secret_access_key" {
  description = "The AWS secret access key for the Vault IAM user"
  type        = string
  sensitive   = true
}
variable "vault_kms_key_id" {
  description = "The KMS key ID of the root key used to seal/unseal Vault"
  type        = string
  sensitive   = true
}

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

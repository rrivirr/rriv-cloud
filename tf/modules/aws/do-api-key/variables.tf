variable "env" {
  type        = string
  description = "Environment name"
}

variable "do_api_key" {
  description = "DigitalOcean API key for Vault operations"
  type        = string
  sensitive   = true
}

variable "vault_iam_user_name" {
  description = "Name of the Vault IAM user"
  type        = string
}
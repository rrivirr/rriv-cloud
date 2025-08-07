variable "env" {
  type        = string
  description = "Environment name"
}

# TODO: rename to do_vault_api_key
variable "do_api_key" {
  description = "DigitalOcean API key for Vault operations"
  type        = string
  sensitive   = true
}

variable "do_github_actions_api_key" {
  description = "DigitalOcean API key for GitHub Actions"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vault_iam_user_name" {
  description = "Name of the Vault IAM user"
  type        = string
}
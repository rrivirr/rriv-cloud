variable "token_reviewer_jwt" {
  description = "JWT token for the Kubernetes service account to review tokens"
  type        = string
}

variable "kubernetes_ca_cert" {
  description = "CA certificate for the Kubernetes API server"
  type        = string
}

variable "vault_auth_service_account_name" {
  description = "Service account name for Vault authentication"
  type        = string
  default     = "vault-auth"
}
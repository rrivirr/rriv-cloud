variable "env" {
  type        = string
  description = "Environment for resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-1"
}

variable "do_region" {
  type        = string
  description = "DigitalOcean region for resources"
  default     = "sfo2"
}

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "vpc_octet" {
  type        = number
  description = "Second octet for VPC IP range (10.X.0.0/16)"
  default     = 10
}

variable "vault_iam_user_access_key_secret_name" {
  type        = string
  description = "The name of the AWS Secrets Manager secret that stores the Vault IAM user access keys"
  default     = "rriv-${var.env}-vault-user-access-keys"
}

variable "vault_cluster_node_count" {
  type        = number
  description = "Number of nodes in the Vault Kubernetes cluster"
  default     = 3
}

variable "rriv_cluster_node_count" {
  type        = number
  description = "Number of nodes in the rriv Kubernetes cluster"
  default     = 3
}

# variable "do_registry_auth_token" {
#   description = "DigitalOcean Container Registry authentication token"
#   sensitive   = true
#   type        = object({})
#   default = {}
# }

# variable "do_github_actions_api_key" {
#   type        = string
#   description = "DigitalOcean API key for GitHub Actions"
#   sensitive   = true
#   default     = ""
# }

# variable "do_token_rriv_cert_manager" {
#   type        = string
#   description = "DigitalOcean API token scoped for domain read/update only. Used by rriv cluster for creating cert-manager resources"
# }

# variable "vault_kms_key_alias" {
#   type        = string
#   description = "The alias of the KMS key used for Vault"
#   default     = "alias/rriv-dev-vault"
# }

# variable "vault_token" {
#   description = "Terraform admin temporary token from vault-kubernetes.sh"
#   type        = string
# }

# variable "keycloak_client_secret" {
#   description = "Keycloak client secret for Terraform. Get this from Keycloak admin console upon initial login"
#   type        = string
#   sensitive   = true
#   default     = ""
# }

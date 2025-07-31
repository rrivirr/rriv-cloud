variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vault_auth_service_account_name" {
  description = "Service account name for Vault authentication"
  type        = string
  default     = "vault-auth"
}

variable "keycloak_auth_service_account_name" {
  description = "Service account name for Keycloak authentication"
  type        = string
  default     = "keycloak-sa"
}

variable "rriv_app_pool_connection_string" {
  description = "Connection string for the ChirpStack application database pool"
  type        = string
}

variable "rriv_app_direct_connection_string" {
  description = "Direct connection string for the ChirpStack application database used for initial migrations"
  type        = string
}

variable "keycloak_db_host" {
  description = "Host for the Keycloak database"
  type        = string
  sensitive   = true
}

variable "keycloak_db_port" {
  description = "Port for the Keycloak database"
  type        = number
}

variable "keycloak_db_name" {
  description = "Name of the Keycloak database"
  type        = string
}

variable "keycloak_db_username" {
  description = "Username for the Keycloak database"
  type        = string
}

variable "keycloak_db_password" {
  description = "Password for the Keycloak database"
  type        = string
}

variable "keycloak_admin_username" {
  description = "Username for the Keycloak admin user"
  type        = string
}

variable "keycloak_admin_password" {
  description = "Password for the Keycloak admin user"
  type        = string
}

variable "rriv_kubernetes_host" {
  description = "Kubernetes API server URL for the RRIV cluster"
  type        = string
}

variable "rriv_token_reviewer_jwt" {
  description = "JWT token for the RRIV Kubernetes service account to review tokens"
  type        = string
  sensitive   = true
}

variable "rriv_kubernetes_ca_cert" {
  description = "CA certificate for the RRIV Kubernetes API server"
  type        = string
}

variable "postgresql_ca_cert" {
  description = "PostgreSQL CA certificate for SSL connections"
  type        = string
}

variable "do_dns_api_key" {
  description = "DigitalOcean API key for External Secrets Operator to manage DNS records"
  type        = string
  sensitive   = true
}

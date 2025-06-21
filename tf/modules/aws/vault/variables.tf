variable "env" {
  type        = string
  description = "Environment name"
}

variable "vault_tls_cert_json" {
  description = "JSON string containing the Vault TLS certificate, key, and CA"
  type        = string
  sensitive   = true
}
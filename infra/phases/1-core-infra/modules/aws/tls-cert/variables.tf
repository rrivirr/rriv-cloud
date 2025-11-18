variable "env" {
  type        = string
  description = "Environment name"
}

# # Requires k8s cluster to be up and running
# # Get this from cert manager
# variable "vault_tls_cert_json" {
#   description = "JSON string containing the Vault TLS certificate, key, and CA"
#   type        =  object({
#     cert = string
#     key  = string
#     ca   = string
#   })
#   sensitive   = true
# }

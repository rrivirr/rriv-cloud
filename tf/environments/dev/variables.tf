variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-west-1"
}

variable "vpn_droplet_size" {
  description = "Droplet size for the Tailscale exit node"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "vpn_ssh_fingerprint" {
  description = "SSH key fingerprint to access the droplet"
  type        = string
}

variable "vpn_tailscale_authkey" {
  type        = string
  description = "Tailscale auth key for the exit node"
}

variable "vault_tls_cert_file" {
  description = "Path to the Vault TLS certificate file"
  type        = string
}

variable "vault_tls_ca_file" {
  description = "Path to the Vault TLS CA file"
  type        = string
}

variable "vault_tls_key_file" {
  description = "Path to the Vault TLS key file"
  type        = string
}
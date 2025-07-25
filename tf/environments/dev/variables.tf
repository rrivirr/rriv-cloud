variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "do_token_rriv_cert_manager" {
  type        = string
  description = "DigitalOcean API token scoped for domain read/update only. Used by rriv cluster for creating cert-manager resources"
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

variable "vault_token" {
  description = "Terraform admin temporary token from vault-kubernetes.sh"
  type        = string
}

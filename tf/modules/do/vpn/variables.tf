variable "do_region" {
  description = "DigitalOcean region for the Tailscale exit node"
  type        = string
}

variable "droplet_size" {
  description = "Droplet size for the Tailscale exit node"
  type        = string
}

variable "ssh_fingerprint" {
  description = "SSH key fingerprint to access the droplet"
  type        = string
}

variable "tailscale_authkey" {
  type        = string
  description = "Tailscale auth key for the exit node"
}
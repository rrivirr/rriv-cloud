resource "digitalocean_vpc" "rriv" {
  name     = "rriv-${var.env}"
  region   = var.region
  ip_range = "10.${var.vpc_octet}.0.0/16"
  description = "VPC for RRIV ${var.env} environment"
}

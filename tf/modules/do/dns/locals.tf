locals {
  root_domain = "rriv.org"
  domain = var.env == "prod" ? local.root_domain : "${var.env}.${local.root_domain}"
}

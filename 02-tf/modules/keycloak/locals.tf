locals {
  realm_display_name = var.env == "prod" ? "rriv-beta" : "rriv-beta-${var.env}"
  realm_display_name_html = var.env == "prod" ? "<strong>rriv-beta</strong>" : "<strong>rriv-beta</strong> [${var.env}]"
  email_from_display_name = var.env == "prod" ? "rriv" : "rriv [${var.env}]"
  rrivctl_subdomain = var.env == "prod" ? "console-chirp" : "console-chirp.${var.env}"
  rrivctl_redirect_relative_uri = "/realms/rriv-beta-dev/account"
}

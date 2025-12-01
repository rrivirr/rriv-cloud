resource "keycloak_realm" "rriv_beta" {
  realm   = "rriv-beta-${var.env}"
  enabled = true

  display_name = var.env == "prod" ? "rriv-beta" : "rriv-beta [${var.env}]"

  ssl_required = "all"
  reset_password_allowed = true
  login_with_email_allowed = true
  registration_allowed = false
  registration_email_as_username = true
  duplicate_emails_allowed = false
  verify_email = true
  password_policy = "upperCase(1) and length(10) and notUsername"

  dynamic "smtp_server" {
    for_each = var.smtp_username != null ? [1] : []
    content {
      host = "smtp.dreamhost.com"
      port = 587
      from = "no-reply@rriv.org"
      from_display_name = local.email_from_display_name
      starttls = true
      ssl = false

      auth {
        username = var.smtp_username
        password = var.smtp_password
      }
    }
  }

  security_defenses {
    headers {
      x_frame_options                     = "DENY"
      content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
      content_security_policy_report_only = ""
      x_content_type_options              = "nosniff"
      x_robots_tag                        = "none"
      x_xss_protection                    = "1; mode=block"
      strict_transport_security           = "max-age=31536000; includeSubDomains"
    }
    brute_force_detection {
      permanent_lockout                 = false
      max_login_failures                = 10
      wait_increment_seconds            = 10
      quick_login_check_milli_seconds   = 1000
      minimum_quick_login_wait_seconds  = 60
      max_failure_wait_seconds          = 900
      failure_reset_time_seconds        = 360
    }
  }
}

variable "app_name" {
  description = "Name of the App Platform app (unique within the account)."
  type        = string
  default     = "rriv-web"
}

variable "region" {
  description = "App Platform region slug (e.g. nyc, sfo, ams, fra, lon, sgp, tor, blr, syd)."
  type        = string
  default     = "nyc"
}

variable "repo_clone_url" {
  description = "Public clone URL of the rriv-web repository."
  type        = string
  default     = "https://github.com/rrivirr/rriv-web.git"
}

variable "branch" {
  description = "Branch to build and deploy."
  type        = string
  default     = "main"
}

# ---------------------------------------------------------------------------
# Build-time values for the Vite app (see README "Environment variables").
# Vite inlines these into the bundle at build time, so they are public in the
# shipped JavaScript — do not put secrets here.
# ---------------------------------------------------------------------------

variable "rriv_api_base_url" {
  description = "VITE_RRIV_API_BASE_URL — base URL of the RRIV REST API."
  type        = string
}

variable "keycloak_url" {
  description = "VITE_KEYCLOAK_URL — base URL of the Keycloak server (no /realms suffix)."
  type        = string
}

variable "keycloak_realm" {
  description = "VITE_KEYCLOAK_REALM — Keycloak realm that issues tokens the API trusts."
  type        = string
  default     = "master"
}

variable "keycloak_client_id" {
  description = "VITE_KEYCLOAK_CLIENT_ID — public (PKCE) Keycloak client ID for the SPA."
  type        = string
  default     = "rriv-web"
}

variable "data_api_url" {
  description = "VITE_DATA_API_URL — optional data-api base URL for telemetry. Leave null to omit."
  type        = string
  default     = null
}

# ---------------------------------------------------------------------------
# Optional custom domain
# ---------------------------------------------------------------------------

variable "custom_domain" {
  description = "Optional custom hostname for the site (e.g. app.rriv.org). Leave null to use only the default ondigitalocean.app URL."
  type        = string
  default     = null
}

variable "custom_domain_zone" {
  description = "If the custom domain's DNS is hosted on DigitalOcean, the zone name (e.g. rriv.org) so App Platform manages the record. Leave null if DNS is elsewhere."
  type        = string
  default     = null
}

variable "project_id" {
  description = "Optional DigitalOcean project ID to place the app in."
  type        = string
  default     = null
}

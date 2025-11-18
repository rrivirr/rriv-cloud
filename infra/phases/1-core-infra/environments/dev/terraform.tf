terraform {
  required_version = ">= 1.12.1"
  required_providers {
    aws         = { source = "hashicorp/aws"   version = ">=5.0" }
    digitalocean = { source = "digitalocean/digitalocean" version = "2.53.0" }
  }

  backend "s3" {
    bucket = "rriv-cloud-dev"
    key    = "core-infra-backend.tfstate"

    endpoints = {
      s3 = "https://sfo2.digitaloceanspaces.com"
    }

    # Deactivate a few AWS-specific checks
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "us-east-1" # Required
  }
}

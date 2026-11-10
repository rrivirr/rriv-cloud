terraform {
  required_version = ">= 1.3"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.107"
    }
  }
}

# Reads the API token from the DIGITALOCEAN_TOKEN environment variable.
provider "digitalocean" {}

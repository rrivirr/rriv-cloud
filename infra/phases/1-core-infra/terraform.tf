terraform {
  required_version = ">= 1.12.1"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.53.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 5.0.0"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 4.0.0"
    }
  }

  # See backend.hcl.example
  # Use the backend file with the command:
  # terraform init -backend-config=backend.hcl

  backend "s3" {
    bucket = "" 
    key    = "backend.tfstate"
    region = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

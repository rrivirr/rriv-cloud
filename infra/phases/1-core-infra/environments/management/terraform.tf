terraform {
  required_version = ">= 1.12.1"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~>2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }

  backend "s3" {
    bucket = "" 
    key    = ""
    region = "us-east-1" # required us-east-1
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
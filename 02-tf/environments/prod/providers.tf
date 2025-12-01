terraform {
  required_version = ">= 1.12.1"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.47.0"
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
    bucket = "rriv-cloud-prod" 
    key    = "backend.tfstate"
    endpoints = {
      s3 = "https://sfo2.digitaloceanspaces.com"
    }

    region = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    use_path_style             = true
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region = var.aws_region
  alias  = "prod-us-west-1"

  default_tags {
    tags = {
      environment = "prod"
      account     = "rriv-prod"
      iac         = "terraform"
      repo        = "github.com/rrivirr/rriv-cloud"
      region      = var.aws_region
    }
  }
}

provider "kubernetes" {
  alias         = "prod-sfo2-k8s-vault"
  config_path    = module.prod_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path
  config_context = "do-${local.do_region}-vault-${local.env}"
}

provider "kubernetes" {
  alias         = "prod-sfo2-k8s-rriv"
  config_path    = module.prod_do_sfo2_k8s_rriv_cluster.cluster_kubeconfig_path
  config_context = "do-${local.do_region}-rriv-${local.env}"
}

provider "vault" {
  alias   = "prod-sfo2-vault"
  address = local.env == "prod" ? "https://vault.rriv.org:8200" : "https://vault.${local.env}.rriv.org:8200"
  token   = var.vault_token
}

provider "keycloak" {
  alias         = "prod-sfo2-keycloak"
  client_id     = "terraform"
  client_secret = var.keycloak_client_secret
  url           = local.env == "prod" ? "https://auth.rriv.org" : "https://auth.${local.env}.rriv.org"
}
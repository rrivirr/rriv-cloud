terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = ">= 5.0.0"
    }
  }
}
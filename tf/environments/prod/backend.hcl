bucket = "rriv-cloud-prod"
key    = "vpn.tfstate"
endpoints = {
  s3 = "https://sfo2.digitaloceanspaces.com"
}

access_key = "" # DO key. DO Spaces does not use AWS credentials, but this is required for the S3 backend.
secret_key = ""

# Deactivate a few AWS-specific checks
skip_credentials_validation = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
skip_region_validation      = true
skip_s3_checksum            = true
region = "us-east-1"

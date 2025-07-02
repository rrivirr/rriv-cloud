module "dev_aws_us-west-1_vault" {
  source = "../../modules/aws/vault-iam-user"
  providers = {
    aws = aws.dev-us-west-1
  }

  env = local.env
  vault_tls_cert_json = local.vault_tls_cert_json
}

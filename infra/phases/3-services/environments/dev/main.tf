module "dev_aws-us-west-1" {
  source = "../../global/aws-us-west-1"

  env = local.env
  aws_region = var.aws_region
  do_region = local.do_region
  do_token = var.do_token
  vpc_octet = local.vpc_octet
  vault_iam_user_access_key_secret_name = local.vault_iam_user_access_key_secret_name
  vault_kms_key_alias = local.vault_kms_key_alias
  vault_token = var.vault_token
  keycloak_client_secret = var.keycloak_client_secret
}
# Sets up the member accounts and SSO identity center
module "rriv_aws_accounts" {
  source = "../modules/aws-accounts"

  aws_region = var.aws_region
}

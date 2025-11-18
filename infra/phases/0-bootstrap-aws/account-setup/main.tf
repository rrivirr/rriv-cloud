# Sets up the member accounts and SSO identity center
module "rriv_aws_accounts" {
  source = "../modules/aws-accounts"
  providers = {
    aws = aws
  }

  aws_region = var.aws_region
  domain_name = var.domain_name
}

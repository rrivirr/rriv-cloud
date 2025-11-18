module "do_sfo2_vpc" {
  source = "../../modules/do/vpc"
  providers = {
    digitalocean = digitalocean
  }

  env        = var.env
  region     = var.do_region
  vpc_octet  = var.vpc_octet

  depends_on =[
    module.cloud_providers
  ]
}

module "aws_us-west-1_keycloak_bootstrap_creds" {
  source = "../../modules/aws/keycloak-bootstrap-creds"
  providers = {
    aws = aws.${var.env}-${var.aws_region}
  }

  env = var.env

  depends_on =[
    module.cloud_providers
  ]
}

module "do_sfo2_postgresdb" {
  source = "../../modules/do/postgresdb"
  providers = {
    digitalocean = digitalocean
  }

  env            = var.env
  vpc_id         = module.do_sfo2_vpc.vpc_id

  depends_on = [
    module.do_sfo2_vpc
  ]
}

# Vault IAM user and KMS key
module "aws_us-west-1_vault" {
  source = "../../modules/aws/vault-iam-user"
  providers = {
    aws = aws.${var.env}-${var.aws_region}
  }

  env = var.env
  iam_user_access_key_secret_name = var.vault_iam_user_access_key_secret_name
  kms_key_alias = var.vault_kms_key_alias

  depends_on =[
    module.cloud_providers
  ]
}

### Modules that depend each other are below

module "aws_us-west-1_do_api_key" {
  source = "../../modules/aws/do-api-key"
  providers = {
    aws = aws.${var.env}-${var.aws_region}
  }

  env = var.env
  do_dns_api_key = var.do_token
  # do_github_actions_api_key = var.do_github_actions_api_key
  vault_iam_user_name = module.aws_us-west-1_vault.vault_iam_user_name

  depends_on = [
    module.aws_us-west-1_vault
  ]
}

module "aws_us-west-1_github_actions" {
  source = "../../modules/aws/github-actions"
  providers = {
    aws = aws.${var.env}-${var.aws_region}
  }

  env = var.env
  secret_github_actions_do_api_key_arn = module.aws_us-west-1_do_api_key.secret_github_actions_do_api_key_arn

  depends_on = [
    module.aws_us-west-1_do_api_key
  ]
}

# Vault k8s cluster
module "do_sfo2_k8s_vault_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env                        = var.env
  service                    = "vault"
  do_region                  = var.do_region
  node_count                 = var.vault_cluster_node_count
  vpc_id                     = module.do_sfo2_vpc.vpc_id

  depends_on = [
    module.do_sfo2_vpc,
    module.aws_us-west-1_do_api_key
  ]
}

# rriv app k8s cluster
module "do_sfo2_k8s_rriv_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env          = var.env
  service      = "rriv"
  do_region    = var.do_region
  node_count   = var.rriv_cluster_node_count
  node_size    = "s-2vcpu-4gb"
  vpc_id       = module.do_sfo2_vpc.vpc_id
  depends_on = [
    module.do_sfo2_vpc,
    module.do_sfo2_k8s_vault_cluster
  ]
}

module "helm_setup" {
  source = "../../modules/helm"
  
  env = var.env

  depends_on = [
    module.do_sfo2_k8s_vault_cluster,
    module.do_sfo2_k8s_rriv_cluster
  ]
}

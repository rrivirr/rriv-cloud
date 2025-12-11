### These modules don't depend on anything except the bootstrap terraform,
### so they can be created anytime

module "staging_do_sfo2_vpc" {
  source = "../../modules/do/vpc"
  providers = {
    digitalocean = digitalocean
  }

  env        = local.env
  region     = local.do_region
  vpc_octet  = local.vpc_octet
}

module "staging_aws_us-west-1_keycloak_bootstrap_creds" {
  source = "../../modules/aws/keycloak-bootstrap-creds"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
}

module "staging_do_sfo2_postgresdb" {
  source = "../../modules/do/postgresdb"
  providers = {
    digitalocean = digitalocean
  }

  env            = local.env
  vpc_id         = module.staging_do_sfo2_vpc.vpc_id

  depends_on = [
    module.staging_do_sfo2_vpc
  ]
}

# Vault IAM user and KMS key
module "staging_aws_us-west-1_vault" {
  source = "../../modules/aws/vault-iam-user"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
  iam_user_access_key_secret_name = var.vault_iam_user_access_key_secret_name
  kms_key_alias = var.vault_kms_key_alias
}

### Modules that depend each other are below

module "staging_aws_us-west-1_do_api_key" {
  source = "../../modules/aws/do-api-key"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
  do_dns_api_key = var.do_token
  do_github_actions_api_key = var.do_github_actions_api_key
  vault_iam_user_name = module.staging_aws_us-west-1_vault.vault_iam_user_name

  depends_on = [
    module.staging_aws_us-west-1_vault
  ]
}

module "staging_aws_us-west-1_github_actions" {
  source = "../../modules/aws/github-actions"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
  secret_github_actions_do_api_key_arn = module.staging_aws_us-west-1_do_api_key.secret_github_actions_do_api_key_arn

  depends_on = [
    module.staging_aws_us-west-1_do_api_key
  ]
}

# Vault k8s cluster
module "staging_do_sfo2_k8s_vault_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env                        = local.env
  service                    = "vault"
  do_region                  = local.do_region
  node_count_min             = local.vault_cluster_node_count_min
  node_count_max             = local.vault_cluster_node_count_max
  node_size                  = local.vault_cluster_node_size
  vpc_id                     = module.staging_do_sfo2_vpc.vpc_id
  k8s_version                = "1.33.1-do.5"

  depends_on = [
    module.staging_do_sfo2_vpc,
    module.staging_aws_us-west-1_do_api_key
  ]
}

# rriv app k8s cluster
module "staging_do_sfo2_k8s_rriv_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env          = local.env
  service      = "rriv"
  do_region    = local.do_region
  node_count_min   = local.rriv_cluster_node_count_min
  node_count_max   = local.rriv_cluster_node_count_max
  node_size    = local.rriv_cluster_node_size
  vpc_id       = module.staging_do_sfo2_vpc.vpc_id
  k8s_version  = "1.33.1-do.5"

  depends_on = [
    module.staging_do_sfo2_vpc,
    module.staging_do_sfo2_k8s_vault_cluster
  ]
}

module "staging_helm_setup" {
  source = "../../modules/helm"
  
  env = local.env

  depends_on = [
    module.staging_do_sfo2_k8s_vault_cluster,
    module.staging_do_sfo2_k8s_rriv_cluster
  ]
}

#####################################################
## THIS IS THE POINT AT WHICH HELM MUST BE APPLIED ##
#####################################################

# TODO: This module actually might need to be applied before helm can finish
module "staging_k8s_sfo2_vault_cluster_secrets" {
  source = "../../modules/k8s/vault-cluster-secrets"
  providers = {
    kubernetes = kubernetes.staging-sfo2-k8s-vault
    aws        = aws.staging-us-west-1
  }

  env                                = local.env
  do_token                           = var.do_token
  do_token_rriv_cert_manager         = var.do_token_rriv_cert_manager
  vault_iam_user_access_key_secret_name = var.vault_iam_user_access_key_secret_name
  vault_kms_key_alias = var.vault_kms_key_alias

  depends_on = [
    module.staging_helm_setup
  ]
}

# k8s secrets for the rriv app
# Most secrets are created by Vault, but there are a couple needed to 
# authenticate rriv with vault
module "staging_k8s_sfo2_rriv_cluster_secrets" {
  source = "../../modules/k8s/rriv-cluster-secrets"
  providers = {
    kubernetes = kubernetes.staging-sfo2-k8s-rriv
  }

  depends_on = [
    module.staging_do_sfo2_k8s_rriv_cluster,
  ]
}

# Vault provider configuration module
module "staging_vault_sfo2" {
  source = "../../modules/vault"
  providers = {
    vault = vault.staging-sfo2-vault
  }

  env                  = local.env
  kv_secret_tags       = local.vault_kv_secret_tags
  rriv_token_reviewer_jwt    = module.staging_k8s_sfo2_rriv_cluster_secrets.vault_auth_token_data
  rriv_kubernetes_ca_cert    = module.staging_k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  rriv_app_direct_connection_string = module.staging_do_sfo2_postgresdb.rriv_app_direct_connection_string
  rriv_app_pool_connection_string = module.staging_do_sfo2_postgresdb.rriv_app_pool_connection_string
  keycloak_db_host          = module.staging_do_sfo2_postgresdb.keycloak_db_host
  keycloak_db_port          = module.staging_do_sfo2_postgresdb.keycloak_db_port
  keycloak_db_name          = module.staging_do_sfo2_postgresdb.keycloak_db_name
  keycloak_db_username      = module.staging_do_sfo2_postgresdb.keycloak_db_username
  keycloak_db_password      = module.staging_do_sfo2_postgresdb.keycloak_db_password
  keycloak_admin_username    = module.staging_aws_us-west-1_keycloak_bootstrap_creds.admin_username
  keycloak_admin_password    = module.staging_aws_us-west-1_keycloak_bootstrap_creds.admin_password
  postgresql_ca_cert         = module.staging_do_sfo2_postgresdb.postgresql_ca_cert
  rriv_kubernetes_host       = module.staging_do_sfo2_k8s_rriv_cluster.cluster_hostname
  do_dns_api_key             = var.do_token_rriv_cert_manager
  do_registry_auth_token     = var.do_registry_auth_token
  data_api_database_url       = module.staging_do_sfo2_postgresdb.data_api_database_url
  rriv_api_database_url       = module.staging_do_sfo2_postgresdb.rriv_api_database_url

  depends_on = [
    module.staging_k8s_sfo2_rriv_cluster_secrets,
    module.staging_do_sfo2_postgresdb
  ]
}

module "staging_keycloak_sfo2" {
  source = "../../modules/keycloak"
  providers = {
    keycloak = keycloak.staging-sfo2-keycloak
  }

  env = local.env
  smtp_username = module.staging_vault_sfo2.keycloak_smtp_creds["username"]
  smtp_password = module.staging_vault_sfo2.keycloak_smtp_creds["password"]

  depends_on = [
    module.staging_vault_sfo2,
    module.staging_aws_us-west-1_keycloak_bootstrap_creds,
    module.staging_k8s_sfo2_vault_cluster_secrets,
  ]
}

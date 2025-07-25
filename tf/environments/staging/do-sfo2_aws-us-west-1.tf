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

  env = local.env
  vpc_id = module.staging_do_sfo2_vpc.vpc_id
}

# Vault IAM user and KMS key
module "staging_aws_us-west-1_vault" {
  source = "../../modules/aws/vault-iam-user"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
}

### Modules that depend each other are below

module "staging_aws_us-west-1_do_api_key" {
  source = "../../modules/aws/do-api-key"
  providers = {
    aws = aws.staging-us-west-1
  }

  env = local.env
  do_api_key = var.do_token
  vault_iam_user_name = module.staging_aws_us-west-1_vault.vault_iam_user_name

  depends_on = [
    module.staging_aws_us-west-1_vault
  ]
}

# # Vault k8s cluster
module "staging_do_sfo2_k8s_vault_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env                        = local.env
  service                    = "vault"
  do_region                  = local.do_region
  node_count                 = local.vault_cluster_node_count

  depends_on = [
    module.staging_do_sfo2_postgresdb,
    module.staging_aws_us-west-1_do_api_key
  ]
}

# # rriv app k8s cluster
module "staging_do_sfo2_k8s_rriv_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env          = local.env
  service      = "rriv"
  do_region    = local.do_region
  node_count   = local.rriv_cluster_node_count
  node_size    = "s-2vcpu-4gb"
  depends_on = [
    module.staging_do_sfo2_k8s_vault_cluster
  ]
}

#####################################################
## THIS IS THE POINT AT WHICH HELM MUST BE APPLIED ##
## You must first run the 00-helm-install.sh script ##
#####################################################

# K8s secrets in the Vault cluster
module "staging_k8s_sfo2_vault_cluster_secrets" {
  source = "../../modules/k8s/vault-cluster-secrets"
  providers = {
    kubernetes = kubernetes.staging-sfo2-k8s-vault
  }

  env                  = local.env
  aws_access_key_id     = module.staging_aws_us-west-1_vault.vault_iam_user_access_key_id
  aws_secret_access_key = module.staging_aws_us-west-1_vault.vault_iam_user_secret_access_key
  vault_kms_key_id      = module.staging_aws_us-west-1_vault.vault_kms_key_id
  do_token     = var.do_token

  depends_on = [
    module.staging_aws_us-west-1_vault,
    module.staging_do_sfo2_k8s_vault_cluster,
  ]
}



# # k8s secrets for the rriv app
# # Most secrets are created by Vault, but there are a couple needed to 
# # authenticate rriv with vault
module "staging_k8s_sfo2_rriv_cluster_secrets" {
  source = "../../modules/k8s/rriv-cluster-secrets"
  providers = {
    kubernetes = kubernetes.staging-sfo2-k8s-rriv
  }

  depends_on = [
    module.staging_do_sfo2_k8s_rriv_cluster,
  ]
}

# # Vault provider configuration module
module "staging_vault_sfo2" {
  source = "../../modules/vault"
  providers = {
    vault = vault.staging-sfo2-vault
  }

  env                  = local.env
  rriv_token_reviewer_jwt    = module.staging_k8s_sfo2_rriv_cluster_secrets.vault_auth_token_data
  rriv_kubernetes_ca_cert    = module.staging_k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  rriv_app_connection_string = module.staging_do_sfo2_postgresdb.rriv_app_connection_string
  keycloak_db_host           = module.staging_do_sfo2_postgresdb.keycloak_db_host
  keycloak_db_port           = module.staging_do_sfo2_postgresdb.keycloak_db_port
  keycloak_db_name           = module.staging_do_sfo2_postgresdb.keycloak_db_name
  keycloak_db_username       = module.staging_do_sfo2_postgresdb.keycloak_db_username
  keycloak_db_password       = module.staging_do_sfo2_postgresdb.keycloak_db_password
  keycloak_admin_username    = module.staging_aws_us-west-1_keycloak_bootstrap_creds.admin_username
  keycloak_admin_password    = module.staging_aws_us-west-1_keycloak_bootstrap_creds.admin_password
  postgresql_ca_cert         = module.staging_do_sfo2_postgresdb.postgresql_ca_cert
  rriv_kubernetes_host       = module.staging_do_sfo2_k8s_rriv_cluster.cluster_hostname
  do_dns_api_key             = var.do_token_rriv_cert_manager

  depends_on = [
    module.staging_k8s_sfo2_rriv_cluster_secrets,
    module.staging_do_sfo2_postgresdb
  ]
}
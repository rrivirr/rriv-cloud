# TODO: keycloak bootstrap creds and postgres secrets must be elsehwere


module "k8s_sfo2_vault_cluster_secrets" {
  source = "../../modules/k8s/vault-cluster-secrets"
  providers = {
    kubernetes = kubernetes.${var.env}-${var.do_region}-k8s-vault
    aws        = aws.${var.env}-${var.aws_region}
  }

  env                                = var.env
  do_token                           = var.do_token
  do_token_rriv_cert_manager         = var.do_token_rriv_cert_manager
  vault_iam_user_access_key_secret_name = var.vault_iam_user_access_key_secret_name
  vault_kms_key_alias = var.vault_kms_key_alias

}

# k8s secrets for the rriv app
# Most secrets are created by Vault, but there are a couple needed to 
# authenticate rriv with vault
module "k8s_sfo2_rriv_cluster_secrets" {
  source = "../../modules/k8s/rriv-cluster-secrets"
  providers = {
    kubernetes = kubernetes.${var.env}-sfo2-k8s-rriv
  }

  depends_on = [
    module.do_sfo2_k8s_rriv_cluster,
  ]
}

# Vault provider configuration module
module "vault" {
  source = "../../modules/vault"
  providers = {
    vault = vault.${var.env}-${var.do_region}-vault
  }

  env                  = var.env
  kv_secret_tags       = var.vault_kv_secret_tags
  rriv_token_reviewer_jwt    = module.k8s_sfo2_rriv_cluster_secrets.vault_auth_token_data 
  rriv_kubernetes_ca_cert    = module.k8s_sfo2_rriv_cluster_secrets.vault_auth_ca_cert
  rriv_app_direct_connection_string = module.do_sfo2_postgresdb.rriv_app_direct_connection_string
  rriv_app_pool_connection_string = module.do_sfo2_postgresdb.rriv_app_pool_connection_string
  keycloak_db_host          = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["db_host"]
  keycloak_db_port          = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["db_port"]
  keycloak_db_name          = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["db_name"]
  keycloak_db_username      = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["db_username"]
  keycloak_db_password      = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["db_password"]
  keycloak_admin_username    = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["admin_username"]
  keycloak_admin_password    = data.aws_secretsmanager_secret_version.keycloak_bootstrap_creds.secret_string["admin_password"]
  postgresql_ca_cert         = module.do_sfo2_postgresdb.postgresql_ca_cert
  rriv_kubernetes_host       = module.do_sfo2_k8s_rriv_cluster.cluster_hostname
  do_dns_api_key             = var.do_token_rriv_cert_manager
  do_registry_auth_token     = var.do_registry_auth_token
  data_api_database_url       = module.do_sfo2_postgresdb.data_api_database_url
  rriv_api_database_url       = module.do_sfo2_postgresdb.rriv_api_database_url

  depends_on = [
    module.k8s_sfo2_rriv_cluster_secrets,
    module.do_sfo2_postgresdb
  ]
}

module "keycloak" {
  source = "../../modules/keycloak"
  providers = {
    keycloak = keycloak.${var.env}-${var.do_region}-keycloak
  }

  env = var.env
  smtp_username = data.aws_secretsmanager_secret_version.keycloak_smtp_creds.secret_string["username"]
  smtp_password = data.aws_secretsmanager_secret_version.keycloak_smtp_creds.secret_string["password"]

  depends_on = [
    module.vault,
    module.k8s_sfo2_vault_cluster_secrets,
  ]
}

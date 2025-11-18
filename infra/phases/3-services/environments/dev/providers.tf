provider "kubernetes" {
  alias         = "dev-sfo2-k8s-vault"
  config_path    = module.dev_do_sfo2_k8s_vault_cluster.cluster_kubeconfig_path
  config_context = "do-${local.do_region}-vault-${local.env}"
}

provider "kubernetes" {
  alias         = "dev-sfo2-k8s-rriv"
  config_path    = module.dev_do_sfo2_k8s_rriv_cluster.cluster_kubeconfig_path
  config_context = "do-${local.do_region}-rriv-${local.env}"
}

provider "vault" {
  alias   = "dev-sfo2-vault"
  address = "https://vault.${local.env}.rriv.org:8200"
  token   = var.vault_token
}

provider "keycloak" {
  alias         = "dev-sfo2-keycloak"
  client_id     = "terraform"
  client_secret = var.keycloak_client_secret
  url           = "https://auth.${local.env}.rriv.org"
}

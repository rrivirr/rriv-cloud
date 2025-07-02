module "dev_do_sfo2_k8s_cluster" {
  source = "../../modules/do/k8s-cluster"
  providers = {
    digitalocean = digitalocean
  }

  env          = local.env
  do_region    = local.do_region
  node_count   = local.cluster_node_count
}

module "dev_do_sfo2_vpn" {
  source = "../../modules/do/vpn"
  providers = {
    digitalocean = digitalocean
  }

  do_region         = local.do_region
  droplet_size      = var.vpn_droplet_size
  ssh_fingerprint   = var.vpn_ssh_fingerprint
  tailscale_authkey = var.vpn_tailscale_authkey
}

module "dev_k8s_sfo2_aws_secrets" {
  source = "../../modules/k8s/secrets"
  providers = {
    kubernetes = kubernetes.dev-sfo2-vault
  }

  env                  = local.env
  aws_access_key_id     = module.dev_aws_us-west-1_vault.vault_iam_user_access_key_id
  aws_secret_access_key = module.dev_aws_us-west-1_vault.vault_iam_user_secret_access_key
  vault_kms_key_id      = module.dev_aws_us-west-1_vault.vault_kms_key_id
  do_token     = var.do_token

  depends_on = [
    module.dev_aws_us-west-1_vault,
    module.dev_do_sfo2_k8s_cluster,
  ]
}
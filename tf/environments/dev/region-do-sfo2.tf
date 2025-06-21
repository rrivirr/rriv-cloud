module "dev_do_sfo2_vpn" {
  source = "../../modules/do/vpn"
  providers = {
    digitalocean = digitalocean
  }

  do_region = local.do_region
  droplet_size = var.vpn_droplet_size
  ssh_fingerprint = var.vpn_ssh_fingerprint
  tailscale_authkey = var.vpn_tailscale_authkey
}

module "dev_k8s_sfo2_aws_access_key" {
  source = "../../modules/k8s/aws-access-key"
  providers = {
    kubernetes = kubernetes
  }

  aws_access_key_id = module.dev_aws_us-west-1_vault.vault_iam_user_access_key_id
  aws_secret_access_key = module.dev_aws_us-west-1_vault.vault_iam_user_secret_access_key

  depends_on = [
    module.dev_aws_us-west-1_vault
  ]
}
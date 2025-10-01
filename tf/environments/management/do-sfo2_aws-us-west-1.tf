module "management_do_sfo2_vpc" {
  source = "../../modules/do/vpc"
  providers = {
    digitalocean = digitalocean.management-sfo2
  }

  env        = local.env
  region     = local.do_region
  vpc_octet  = local.vpc_octet
}

module "do_sfo2_headscale" {
  source = "../../modules/do/headscale"
  providers = {
    digitalocean = digitalocean.management-sfo2
  }

  ssh_key_public     = var.ssh_key_public
  admin_ip           = var.ssh_admin_ip
  oidc_issuer        = var.headscale_oidc_issuer
  oidc_client_id     = var.headscale_oidc_client_id
  oidc_client_secret = var.headscale_oidc_client_secret

  depends_on = [
    module.management_do_sfo2_vpc,
  ]
}

module "do_sfo2_lb_ips_dev" {
  source = "../../modules/do/lb-ips"

  providers = {
    digitalocean = digitalocean.dev-sfo2
  }

  env = "dev"
}

module "do_sfo2_dns_dev" {
  source = "../../modules/do/dns"

  providers = {
    digitalocean = digitalocean.management-sfo2
  }
  
  env = "dev"
  rriv_org_lb_ip = module.do_sfo2_lb_ips_dev.rriv_org_lb_ip
  chirp_lb_ip = module.do_sfo2_lb_ips_dev.chirp_lb_ip
  chirp_console_lb_ip = module.do_sfo2_lb_ips_dev.chirp_console_lb_ip
  vault_lb_ip = module.do_sfo2_lb_ips_dev.vault_lb_ip

  depends_on = [
    module.do_sfo2_lb_ips_dev
  ]
}

# module "do_sfo2_lb_ips_staging" {
#   source = "../../modules/do/lb-ips"

#   providers = {
#     digitalocean = digitalocean.staging-sfo2
#   }

#   env = "staging"
# }

# module "do_sfo2_dns_staging" {
#   source = "../../modules/do/dns"

#   providers = {
#     digitalocean = digitalocean.management-sfo2
#   }

#   domain = "staging.rriv.org"
#   rriv_org_lb_ip = module.do_sfo2_lb_ips_staging.rriv_org_lb_ip
#   chirp_lb_ip = module.do_sfo2_lb_ips_staging.chirp_lb_ip
#   chirp_console_lb_ip = module.do_sfo2_lb_ips_staging.chirp_console_lb_ip
#   vault_lb_ip = module.do_sfo2_lb_ips_staging.vault_lb_ip

#   depends_on = [
#     module.do_sfo2_lb_ips_staging
#   ]
# }

# module "do_sfo2_lb_ips_prod" {
#   source = "../../modules/do/lb-ips"

#   providers = {
#     digitalocean = digitalocean.prod-sfo2
#   }

#   env = "prod"
# }

# module "do_sfo2_dns_prod" {
#   source = "../../modules/do/dns"

#   providers = {
#     digitalocean = digitalocean.management-sfo2
#   }

#   domain = "rriv.org"
#   rriv_org_lb_ip = module.do_sfo2_lb_ips_prod.rriv_org_lb_ip
#   chirp_lb_ip = module.do_sfo2_lb_ips_prod.chirp_lb_ip
#   chirp_console_lb_ip = module.do_sfo2_lb_ips_prod.chirp_console_lb_ip
#   vault_lb_ip = module.do_sfo2_lb_ips_prod.vault_lb_ip

#   depends_on = [
#     module.do_sfo2_lb_ips_prod
#   ]
# }
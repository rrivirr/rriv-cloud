module "dev_do-sfo2_aws-us-west-1" {
  source = "../global/do-sfo2_aws-us-west-1" 

  do_token = var.do_token
  aws_region = var.aws_region
  env = local.env
  do_region = local.do_region
  vpc_octet = local.vpc_octet
  vault_cluster_node_count = local.vault_cluster_node_count
  rriv_cluster_node_count = local.rriv_cluster_node_count
}
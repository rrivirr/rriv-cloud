resource "digitalocean_kubernetes_cluster" "vault" {
  name    = "vault-${var.env}"
  region  = var.do_region
  version = var.k8s_version

  node_pool {
    name       = "vault-${var.env}-pool"
    size       = var.node_size
    node_count = var.node_count
  }
}

resource "local_file" "vault_kubeconfig" {
  content  = digitalocean_kubernetes_cluster.vault.kube_config[0].raw_config
  filename = "${path.module}/kubeconfig-${var.env}.yaml"
}

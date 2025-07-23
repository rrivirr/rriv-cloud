resource "digitalocean_kubernetes_cluster" "cluster" {
  name     = "${var.service}-${var.env}"
  region   = var.do_region
  version  = var.k8s_version
  vpc_uuid = var.vpc_id

  node_pool {
    name       = "${var.service}-${var.env}-pool"
    size       = var.node_size
    node_count = var.node_count
  }

  lifecycle {
    # DO NOT disable this - all vault data will be lost
    # See README for instructions on how to upgrade the node size safely
    # prevent_destroy = true
  }
}

resource "local_file" "cluster_kubeconfig" {
  content  = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  filename = "${path.module}/kubeconfig/${var.service}-${var.env}.yaml"
}


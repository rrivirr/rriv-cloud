resource "digitalocean_kubernetes_cluster" "cluster" {
  name     = "${var.service}-${var.env}"
  region   = var.do_region
  version  = var.k8s_version
  vpc_uuid = var.vpc_id

  node_pool {
    name       = "${var.service}-${var.env}-pool"
    size       = var.node_size
    node_count = var.node_count
    tags      = ["cluster:${var.service}"]
  }

  lifecycle {
    # DO NOT disable this - all vault data will be lost
    # See README for instructions on how to upgrade the node size safely
    prevent_destroy = true
  }
}

# TODO: move this OUT of the repo so AI agents don't look at it!
resource "local_file" "cluster_kubeconfig" {
  content  = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  filename = "${path.module}/kubeconfig/${var.service}-${var.env}.yaml"
}

resource "digitalocean_firewall" "allow_smtp_egress" {
  count = var.service == "rriv" ? 1 : 0
  name = "rriv-${var.env}-allow-smtp-egress"

  outbound_rule {
    protocol           = "tcp"
    port_range         = "587"
    destination_addresses = ["0.0.0.0/0"]
  }

  tags = ["cluster:rriv"]
}

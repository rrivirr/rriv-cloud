output "cluster_kubeconfig" {
  value = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  sensitive = true
}

output "cluster_kubeconfig_path" {
  value = abspath(local_file.cluster_kubeconfig.filename)
  description = "Path to the kubeconfig file for the cluster Kubernetes cluster"
}

output "cluster_hostname" {
  value = digitalocean_kubernetes_cluster.cluster.endpoint
  description = "Hostname of the Kubernetes cluster"
}

output "cluster_id" {
  value = digitalocean_kubernetes_cluster.cluster.id
  description = "ID of the Kubernetes cluster"
}
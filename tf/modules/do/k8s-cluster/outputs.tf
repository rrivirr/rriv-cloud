output "vault_kubeconfig" {
  value = digitalocean_kubernetes_cluster.vault.kube_config[0].raw_config
  sensitive = true
}

output "vault_kubeconfig_path" {
  value = abspath(local_file.vault_kubeconfig.filename)
  description = "Path to the kubeconfig file for the Vault Kubernetes cluster"
}
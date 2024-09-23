data "digitalocean_kubernetes_cluster" "kubernetes-cluster-prod-1-data" {
  name = "prod-1"
}

output "kubernetes-cluster-prod-1-output" {
  description = "The Kubernetes cluster prod 1 output data"
  value       = data.digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1-data.kube_config[0]
  sensitive   = true
}

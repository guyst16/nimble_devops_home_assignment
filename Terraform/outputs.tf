data "digitalocean_kubernetes_cluster" "kubernetes-cluster-prod-1-data" {
  name       = "prod-1"
  depends_on = [digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1]
}

data "kubernetes_service" "ngingx-loadbalancer-service" {
  metadata {
    name      = var.k8s-ingress-nginx.loadbalancer_service
    namespace = var.k8s-ingress-nginx.namespace
  }
  depends_on = [helm_release.ingress-nginx]
}

data "digitalocean_domain" "web-app-domain" {
  name = var.web-app-domain
}

output "kubernetes-cluster-prod-1-output" {
  description = "The Kubernetes cluster prod 1 output data"
  value       = try(data.digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1-data.kube_config[0])
  depends_on  = [data.digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1-data]
  sensitive   = true
}

output "nginx-load-blancer-ip" {
  description = "The cluster loadblancer entrance ip address"
  value       = data.kubernetes_service.ngingx-loadbalancer-service.status[0].load_balancer[0].ingress[0].ip
  depends_on  = [data.kubernetes_service.ngingx-loadbalancer-service]
}

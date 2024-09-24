terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
# variable "do_token" {} 

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "kubernetes-cluster-prod-1" {
  name    = var.k8s-cluster-prod-1.name
  region  = var.k8s-cluster-prod-1.region
  version = var.k8s-cluster-prod-1.version

  node_pool {
    name       = var.k8s-cluster-prod-1.node_pool.name
    size       = var.k8s-cluster-prod-1.node_pool.size
    auto_scale = true
    min_nodes  = var.k8s-cluster-prod-1.node_pool.min_nodes
    max_nodes  = var.k8s-cluster-prod-1.node_pool.max_nodes
  }
}

# Configure Kubernetes provider
provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.endpoint
  token = digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.kube_config[0].cluster_ca_certificate
  )
}

# Configure Helm for the Kubernetes cluster 
provider "helm" {
  #  version = "~> 2.15.0"
  kubernetes {
    host  = digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.endpoint
    token = digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.kube_config[0].token

    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.kubernetes-cluster-prod-1.kube_config[0].cluster_ca_certificate
    )
  }
}

# Create the NGINX ingress controller resources
resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.k8s-ingress-nginx.namespace
  }
}

resource "helm_release" "ingress-nginx" {
  name  = var.helm-ingress-nginx.name
  repository = var.helm-ingress-nginx.repository
  chart = var.helm-ingress-nginx.chart
  namespace = var.k8s-ingress-nginx.namespace

  depends_on = [ kubernetes_namespace.ingress ]
}

# Create an "A" domain record
resource "digitalocean_record" "web-app-record" {
  domain = data.digitalocean_domain.web-app-domain.id
  type   = "A"
  name   = var.web-app-record
  value  = data.kubernetes_service.ngingx-loadbalancer-service.status[0].load_balancer[0].ingress[0].ip

  depends_on = [data.kubernetes_service.ngingx-loadbalancer-service]
}

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

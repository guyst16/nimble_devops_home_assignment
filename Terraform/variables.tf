variable "do_token" {
  type        = string
  description = "DigitalOcean API token" 
  sensitive   = true
}

variable "k8s-cluster-prod-1" {
  type        = object({
                  name      = string
                  region    = string
                  version   = string 
                  node_pool = object({
                    name       = string 
                    size       = string 
                    auto_scale = bool 
                    min_nodes  = number
                    max_nodes  = number
                  })
                })
  description = "Kubernetes cluster in the production environment" 
}

variable "k8s-ingress-nginx" {
  type        = object({
                  namespace            = string
                  loadbalancer_service = string
                })
  description = "Ingress Nginx metadata" 
}

variable "helm-ingress-nginx" {
  type        = object({
                  name       = string
                  repository = string
                  chart      = string
                })
  description = "Ingress Nginx helm chart"
}

variable "web-app-record" {
  type        = string
  description = "The web app domain record address"
}

variable "web-app-domain" {
  type        = string
  description = "The web app domain"
}

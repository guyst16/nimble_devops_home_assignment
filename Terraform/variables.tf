variable "do_token"{
  type        = string
  description = "DigitalOcean API token" 
  sensitive   = true
}

variable "k8s-cluster-prod-1"{
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

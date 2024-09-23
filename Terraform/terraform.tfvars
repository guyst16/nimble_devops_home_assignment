# K8S cluster variables
k8s-cluster-prod-1 = {
	name    = "prod-1"
	region  = "blr1"
	version = "1.31.1-do.0"
	node_pool = {
	  	name       = "workers"
	  	size       = "s-2vcpu-2gb"
	  	auto_scale = true
	  	min_nodes  = 2
	  	max_nodes  = 5
}}

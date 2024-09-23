Preqruisites:
    1. Install Terraform CLI - Please follow https://developer.hashicorp.com/terraform/install accordingly to your distribution
    2. Create DigitalOcean API token with all the Kubernetes scopes, please follow https://docs.digitalocean.com/reference/api/create-personal-access-token/

Steps:
    1. Run "terraform init" to create the needed files 
    2. Run "terraform plan --var-file=terraform.tfvars" and pass the DigitalOcean API token to make sure the needed changes of the cluster creation are going to be made
    3. Run "terraform apply --var-file=terraform.tfvars" and pass the DigitalOcean API token for the k8s cluster creation
    ** It is not recommended to save th DigitalOcean API token in the variables files**

## Preqruisites:
* Install Terraform CLI - Please follow https://developer.hashicorp.com/terraform/install accordingly to your distribution
* Create DigitalOcean API token with all the Kubernetes scopes and put it under the `TF_API_TOKEN` secret, please follow https://docs.digitalocean.com/reference/api/create-personal-access-token/

## Steps:
1. Create the needed Terraform files run:
```
$ terraform init
```
2. Make sure the needed changes for the Kubernetes cluster creation are going to be made buy running the next command and **passing the DigitalOcean API token**:
```
$ terraform plan --var-file=terraform.tfvars
```
3. Apply the Kubernetes cluster creation by running the next command and **passing the DigitalOcean API token**:
```
$ terraform apply --var-file=terraform.tfvars
```
>[!WARNING]
>It is not recommended to save th DigitalOcean API token in the variables files

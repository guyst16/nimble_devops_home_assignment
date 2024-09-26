# nimbleway_devops_home_assignment

**About the directories**:
* Cert_manager - Contains the cert manager operator resources
* Docker_resources - Contains the web app docker image resources
* Kubernetes_resources - Contains the K8S resources for the web app deployment process
* Terraform - Contains the resources for the K8S cluster creation process, read about the Terroform resources [here](https://github.com/guyst16/nimbleway_devops_home_assignment/blob/main/Terraform/README.md)

## About
### Terraform
This project helps to create a K8S cluster over DigitalOcean cloud using terraform, about the components:
* K8S cluster with horizontal scaling, min: 2 and max: 5.
* Nginx controller and DigitialOcean loadbalancer for ingress connections
* "app.nimbleassignment.com" subdomain record for the app which points to the loadbalancer IP.

### Github Actions
The CICD creates the docker image, pushes it to the [repository](https://hub.docker.com/r/nimblewayhomeassignment/nimblewayhomeassignment/tags) and deploys it over the mentioned K8S cluster, about the components:
* Ingress for the subdomain "app.nimbleassignment.com" to the app
* Wep app deployment
* Web app service
* Web app namespace

Secrets (only for collaborators):
* DOCKERHUB_TOKEN - The Docker.io repository token
* DOCKERHUB_USERNAME - The Docker.io repository username
* TF_API_TOKEN - The DigitalOcean api key for the terraform deployment process.

Env variables (only for collaborators):
* K8S_CLUSTER_NAME - the K8S cluster name in DigitalOcean

### SSL Implementation
The SSL implementation is happening thanks to `Cert Manager` controller which is a certificate controller that creates certificate signing requests and uses `Letsencrypt` CA to sign them for ingress components with host domain and tls request.
The `Cert Manager` listens to ingress components creation using webhooks and creates the certificate signing request and signs it using the cluster issuer provided.

## How to
- To create the K8S cluster and use terraform please check [here](https://github.com/guyst16/nimbleway_devops_home_assignment/blob/main/Terraform/README.md)
- To deploy the app just go to [here](https://github.com/guyst16/nimbleway_devops_home_assignment/actions/workflows/main_workflow.yml) and click **run workflow** or make any change in the repository to activate the CICD workflow.

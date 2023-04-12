### Mediawiki_AKS

This repository describes, how to setup Mediawiki step by step in Azure Kubernetes Service

#### Pre-requisites to use this github code :
- Azure Account with an active subscription
- Service principal account with contributor access on the subscription to deploy ACR and AKS
- Terraform installed machine or Azure Devops pipeline

#### Steps to configure the AKS & ACR:
- Ensure to provide all the required Azure subscription SP details in terraform.tf
- Run the **azurepipeline_tf.yml**, it will deploy the ACR and AKS in Azure Cloud

#### Download the mediawiki & mysql images from docker hub and push to ACR using below commands:
- docker pull mediawiki
- docker pull mysql
- docker tag mediawiki myacr.azurecr.io/mediawiki:v1 
- docker tag mysql myacr.azurecr.io/mysql:v1 
- docker push myacr.azurecr.io/mediawiki:v1 
- docker push myacr.azurecr.io/mysql:v1 

#### Deploy the Secrets and ConfigMap to AKS using below commands Manually
**Ensure Secrets and Configmap objects are deployed in AKS before deploying the manifest files, because we are reffering the data in secrets and configmap in the deployment YAML Files**
- kubectl apply secrets.yaml
- Kubectl apply configmap.yaml

#### Deploy the Mediawiki & mysql objects to AKS
- Run the **azurepipeline_aks.yml** to deploy the mediawiki and mysql objects in AKS
- After deployment fetch the LB IP and browse the Mediawiki application

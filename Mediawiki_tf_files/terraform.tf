terraform {
  required_version = "~> 1.4.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
    }
  }
}

provider "azurerm" {
  client_id       = "CLINET_ID"
  client_secret   = ""          #Passing value as ENV Varaible from Pipeline
  tenant_id       = "TENANAT_ID"
  subscription_id = "SUBSCRIPTION_ID"

  features {}
}



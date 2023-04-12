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
  client_id       = ""
  client_secret   = var.sp
  tenant_id       = ""
  subscription_id = ""

  features {}
}



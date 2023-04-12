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
  client_id       = "c4fdd105-c1e1-4e9b-86bc-322114e93639"
  client_secret   = var.sp
  tenant_id       = "dffdd786-a9d0-43c2-ba4d-a11e3bef210b"
  subscription_id = "1784f138-8764-4ad4-9b03-5374b8c4db22"

  features {}
}



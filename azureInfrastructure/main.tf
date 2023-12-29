terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = "<azure_subscription_id>"
  tenant_id         = "<azure_subscription_tenant_id>"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>"
}


# Create a resource group
resource "azurerm_resource_group" "primary" {
    name = "de_demo_rg"
    location = "eastus"
}


#Create an Azure Storage Account
resource azurerm_storage_account "primary" {
    name = "de_demo_storage"
    resource_group_name = azurerm_resource_group.primary.name
    location = azurerm_resource_group.primary.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = "LRS"
}

#Create a Blob Container within Storage Account

resource azurerm_storage_container "datasetsInitial" {
    name = "datasetsInitial"
    stor
}
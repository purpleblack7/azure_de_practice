terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

variable "ARM_SUBSCRIPTION_ID" {
  type = string 
}


variable "ARM_TENANT_ID" {
  type = string 
}

variable "ARM_CLIENT_ID" {
  type = string 
}

variable "ARM_CLIENT_SECRET" {
  type = string 
}

provider "azurerm" {
  features {}

  subscription_id   = var.ARM_SUBSCRIPTION_ID
  tenant_id         = var.ARM_TENANT_ID
  client_id         = var.ARM_CLIENT_ID
  client_secret     = var.ARM_CLIENT_SECRET
}


# Create a resource group
resource "azurerm_resource_group" "rg" {
    name = "de_demo_rg"
    location = "eastus"
}


#Create an Azure Storage Account
resource azurerm_storage_account "store" {
    name = "deDemoStorage"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = "LRS"
}

#Create a Blob Container within Storage Account

resource azurerm_storage_container "blob" {
    name = "content"
    storage_account_name = azurerm_resource_group.store.name
    container_access_type = "private"
}
locals {
  common_tags = {
    environment = var.environment
    owner       = var.owner
    project     = var.project
    costcenter  = var.costcenter
    managed_by  = "terraform"
  }
}
# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "etic-notes-${var.environment}-rg"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  vnet_name          = "etic-notes-${var.environment}-vnet"
  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    app = {
      address_prefix = "10.0.1.0/24"
    }

    private-endpoints = {
      address_prefix = "10.0.2.0/24"
    }
  }

  tags = local.common_tags
}
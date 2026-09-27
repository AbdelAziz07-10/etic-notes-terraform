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

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets            = var.subnets

  tags = local.common_tags
}

module "storage" {
  source = "./modules/storage"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  storage_account_name = var.storage_account_name

  private_endpoint_subnet_id = module.network.subnet_ids[
    var.private_endpoint_subnet_name
  ]

  tags = local.common_tags
}
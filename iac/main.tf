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
  name     = var.resource_group_name
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

module "webapp" {
  source = "./modules/webapp"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  app_service_plan_name = var.app_service_plan_name
  web_app_name          = var.web_app_name
  managed_identity_name = var.managed_identity_name
  key_vault_name        = var.key_vault_name

  app_subnet_id = module.network.subnet_ids["app"]

  tags = local.common_tags
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.common_tags
}

resource "azurerm_monitor_diagnostic_setting" "webapp" {
  name                       = "webapp-diagnostics"
  target_resource_id         = module.webapp.web_app_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage" {
  name                       = "storage-diagnostics"
  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_metric {
    category = "AllMetrics"
  }
}
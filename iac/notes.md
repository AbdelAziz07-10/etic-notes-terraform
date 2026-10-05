`main.tf` 

`locals`
locals defines reusable internal values and dynamically computed maps (combining variables and constants) so you can avoid repetition across your configuration.

`common_tags`
It opens a map block named common_tags to group key-value pairs for resource tagging.

`environment = var.environment`
It dynamically assigns the environment name (e.g., dev or stage) from var.environment to the mandatory environment tag key.

`owner = var.owner`
It assigns the resource owner name from var.owner to the mandatory owner tag key.


`project = var.project`
It assigns the project name from var.project to the mandatory project tag key

`costcenter  = var.costcenter`
It assigns the billing code from var.costcenter to the mandatory costcenter tag key for financial tracking.

`managed_by  = "terraform"`
It sets a static tag managed_by = "terraform" to identify resources provisioned via Infrastructure as Code and prevent unauthorized manual changes.

`resource "azurerm_resource_group" "main"`
It declares a new Azure Resource Group resource in Terraform with the local reference name main.

` name     = "etic-notes-${var.environment}-rg"`
It dynamically constructs the Resource Group name using string interpolation based on var.environment to follow the required naming pattern (e.g., etic-notes-dev-rg).

`location = var.location`
It sets the Azure region for the Resource Group dynamically from var.location to avoid hardcoding values.   

`tags     = local.common_tags`
It attaches the complete map of mandatory Azure tags defined in local.common_tags to the Resource Group.

`module "network"`
It instantiates the reusable child network module within the root configuration under the local name network.

`source = "./modules/network"`
It specifies the relative local directory path where the source code for the child network module is located.

`resource_group_name = azurerm_resource_group.main.name`
It dynamically passes the created Resource Group's name to the network module, establishing an implicit dependency to ensure correct provisioning order.

`  location            = var.location`
It passes the Azure region variable down to the child network module to ensure all resources are created in the same location.

`vnet_name          = var.vnet_name`
`vnet_address_space = var.vnet_address_space`
`subnets = var.subnets`
`tags = local.common_tags`
They pass the VNet name, IP address space, subnet definitions map, and unified tags into the child network module.

`module "storage"`
`source = "./modules/storage"`

`resource_group_name = azurerm_resource_group.main.name`
`location = var.location`
`storage_account_name = var.storage_account_name`

`private_endpoint_subnet_id = module.network.subnet_ids[
    var.private_endpoint_subnet_name
 ]`
`tags = local.common_tags`
It provisions the Storage module using the Resource Group name, location, storage account name, mandatory tags, and links the Private Endpoint to the target subnet ID retrieved from the network module outputs.

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
It provisions the WebApp module—including App Service Plan, Web App, Managed Identity, and Key Vault—using the Resource Group, naming variables, unified tags, and links VNet Integration via the "app" subnet ID output.

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.common_tags
}
It provisions a central Azure Log Analytics Workspace using standard pay-as-you-go pricing (PerGB2018), a 30-day data retention policy, dynamic location, and unified mandatory tags.

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
It routes all operational logs and performance metrics from the Web App directly to the central Log Analytics Workspace for real-time monitoring and analysis.

resource "azurerm_monitor_diagnostic_setting" "storage" {
  name                       = "storage-diagnostics"
  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_metric {
    category = "AllMetrics"
  }
}
It routes all performance metrics from the Storage Account to the central Log Analytics Workspace for continuous telemetry and capacity monitoring.

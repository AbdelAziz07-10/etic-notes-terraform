variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "costcenter" {
  description = "Cost center for billing and tracking"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    address_prefix = string
  }))
}
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "private_endpoint_subnet_name" {
  description = "Name of the subnet used for private endpoints"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "web_app_name" {
  description = "Name of the Web App"
  type        = string
}

variable "managed_identity_name" {
  description = "Name of the User Assigned Managed Identity"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}
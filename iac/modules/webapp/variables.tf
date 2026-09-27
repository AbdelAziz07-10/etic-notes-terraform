variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
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

variable "tags" {
  description = "Tags to apply to Web App resources"
  type        = map(string)
}

variable "app_subnet_id" {
  description = "ID of the subnet used for Web App VNet integration"
  type        = string
}
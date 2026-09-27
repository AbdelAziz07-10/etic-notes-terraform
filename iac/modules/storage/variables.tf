variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet used for the private endpoint"
  type        = string
}

variable "tags" {
  description = "Tags to apply to storage resources"
  type        = map(string)
}
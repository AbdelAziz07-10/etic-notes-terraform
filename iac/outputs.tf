output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "IDs of the network subnets"
  value       = module.network.subnet_ids
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage.storage_account_id
}

output "web_app_url" {
  description = "Default URL of the Web App"
  value       = module.webapp.web_app_url
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.webapp.key_vault_uri
}
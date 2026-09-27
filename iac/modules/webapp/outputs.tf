output "web_app_url" {
  description = "Default URL of the Web App"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "managed_identity_principal_id" {
  description = "Principal ID of the Web App managed identity"
  value       = azurerm_user_assigned_identity.main.principal_id
}

output "web_app_id" {
  description = "ID of the Web App"
  value       = azurerm_linux_web_app.main.id
}
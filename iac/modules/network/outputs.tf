output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value = {
    for name, subnet in azurerm_subnet.main :
    name => subnet.id
  }
}
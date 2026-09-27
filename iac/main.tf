# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "etic-notes-${var.environment}-rg"
  location = var.location
  tags = {
    environment = var.environment
    owner = var.owner
    project = var.project
    costcenter = var.costcenter
    managed_by = "Terraform"
  }
}
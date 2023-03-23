resource "azurerm_resource_group" "adl_rg" {
  name     = "rg-${var.prefix}-${var.postfix}${var.env}"
  location = var.location
  tags     = var.tags
}

output "name" {
  value = azurerm_resource_group.adl_rg.name
}

output "location" {
  value = azurerm_resource_group.adl_rg.location
}
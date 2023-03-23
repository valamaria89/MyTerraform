locals {
  safe_prefix  = replace(var.prefix, "-", "")
  safe_postfix = replace(var.postfix, "-", "")
}

resource "azurerm_container_registry" "cr" {
  name                = "cr${local.safe_prefix}${local.safe_postfix}${var.env}"
  resource_group_name = "rg-${var.prefix}-${var.postfix}${var.env}"
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true

  tags = var.tags
}

output "id" {
  value = azurerm_container_registry.cr.id
}
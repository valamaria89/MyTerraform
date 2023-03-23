resource "azurerm_application_insights" "appi" {
  name                = "appi-${var.prefix}-${var.postfix}${var.env}"
  location            = var.location
  resource_group_name = "rg-${var.prefix}-${var.postfix}${var.env}"
  application_type    = "web"

  tags = var.tags
}

output "id" {
  value = azurerm_application_insights.appi.id
}
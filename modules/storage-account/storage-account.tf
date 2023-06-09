data "azurerm_client_config" "current" {}

data "http" "ip" {
  url = "https://ifconfig.me"
}


locals {
  safe_prefix  = replace(var.prefix, "-", "")
  safe_postfix = replace(var.postfix, "-", "")
}

resource "azurerm_storage_account" "st" {
  name                     = "st${local.safe_prefix}${local.safe_postfix}${var.env}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = var.tags
  
}

output "id" {
  value = azurerm_storage_account.st.id
}

output "name" {
  value = azurerm_storage_account.st.name
}
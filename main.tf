# Resource group

terraform {
  backend "azurerm" {   
    resource_group_name  = "rg-ml-testing-mgmt"	
    storage_account_name = "stvalamgmgt001"
    container_name       = "state"
    key                  = "terraform.tfstate"
  }
}


module "resource_group" {
  source = "./modules/resourcegroups/resource-groups"

  location = var.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  tags = local.tags
}

# Azure Machine Learning workspace

module "aml_workspace" {
  source = "./modules/aml-workspace"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  storage_account_id      = module.storage_account_aml.id
  key_vault_id            = module.key_vault.id
  application_insights_id = module.application_insights.id
  container_registry_id   = module.container_registry.id

  enable_aml_computecluster = var.enable_aml_computecluster
  storage_account_name      = module.storage_account_aml.name

  tags = local.tags
}

# Storage account

module "storage_account_aml" {
  source = "./modules/storage-account"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  hns_enabled                         = false
  firewall_bypass                     = ["AzureServices"]
  firewall_virtual_network_subnet_ids = []

  tags = local.tags
}

# Key vault

module "key_vault" {
  source = "./modules/key-vault"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  tags = local.tags
}

# Application insights

module "application_insights" {
  source = "./modules/application-insights"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  tags = local.tags
}

# Container registry

module "container_registry" {
  source = "./modules/container-registry"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.environment

  tags = local.tags
}
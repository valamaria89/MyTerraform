# Resource group

terraform {
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "=2.48.0"
        }
      }
    }
    
    provider "azurerm" {
      features {}
    }
    
    terraform {
      backend "azurerm" {
      }
    }


module "resource_group" {
  source = "./modules/resourcegroups"

  location = var.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env

  tags = var.tags
}

# Azure Machine Learning workspace

module "aml_workspace" {
  source = "./modules/azm-workspace"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env

  storage_account_id      = module.storage_account_aml.id
  key_vault_id            = module.key_vault.id
  application_insights_id = module.application_insights.id
  container_registry_id   = module.container_registry.id

  enable_aml_computecluster = var.enable_aml_computecluster
  storage_account_name      = module.storage_account_aml.name

  tags = var.tags
}

# Storage account

module "storage_account_aml" {
  source = "./modules/storage-account"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env



  tags = var.tags
}

# Key vault

module "key_vault" {
  source = "./modules/key-vault"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env

  tags = var.tags
}

# Application insights

module "application_insights" {
  source = "./modules/application-insights"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env

  tags = var.tags
}

# Container registry

module "container_registry" {
  source = "./modules/container-registry"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  prefix  = var.prefix
  postfix = var.postfix
  env = var.env

  tags = var.tags
}

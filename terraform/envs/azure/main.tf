terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
    } 
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

module "resource_group" {
  source = "../../modules/RG"
  resource_group_name_prefix = var.resource_group_name_prefix
  resource_group_location    = var.resource_group_location
}

module "container_registry" {
  source = "../../modules/ACR"
  container_location = var.resource_group_location
  container_sku = var.container_sku
  container_name = var.container_name
  container_resource_group_name = module.resource_group.resource_group_name
}

module "web_app" {
  source                  = "../../modules/AAS"
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = var.resource_group_location
  web_app_name                  = var.web_app_name
  plan_name                    = var.plan_name
  plan_sku                      = var.plan_sku
  registry_container_image_name = var.registry_container_image_name
  registry_container_url        = "https://${var.container_name}.azurecr.io"
}

resource "azurerm_role_assignment" "webapp_acr_pull" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${module.resource_group.resource_group_name}/providers/Microsoft.ContainerRegistry/registries/${var.container_name}"
  role_definition_name = "AcrPull"
  principal_id         = module.web_app.intens_web_app_id
}

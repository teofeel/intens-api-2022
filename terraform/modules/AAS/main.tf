resource "azurerm_service_plan" "intensappplan" {
  name                = var.plan_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = var.plan_os
  sku_name            = var.plan_sku
}

resource "azurerm_linux_web_app" "intenswebapp" {
  name                  = var.web_app_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  service_plan_id       = azurerm_service_plan.intensappplan.id
  depends_on            = [azurerm_service_plan.intensappplan]
  https_only            = true
  

  identity {
    type = "SystemAssigned"
  }

  site_config { 
    minimum_tls_version = "1.2"
    always_on           = false
    container_registry_use_managed_identity = true
    
    application_stack {
      docker_image_name = var.registry_container_image_name
      docker_registry_url = var.registry_container_url
    }
  }
}

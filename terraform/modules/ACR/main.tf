resource "azurerm_container_registry" "intens_container" {
    name = var.container_name
    resource_group_name = var.container_resource_group_name
    location = var.container_location
    sku = var.container_sku
}
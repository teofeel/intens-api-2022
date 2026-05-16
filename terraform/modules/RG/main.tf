resource "azurerm_resource_group" "intens" {
  location = var.resource_group_location
  name     = var.resource_group_name_prefix
}
output "container_registry_name" {
  value = var.container_name
}

output "container_registry_login_server" {
  value = azurerm_container_registry.intens_container.login_server
}
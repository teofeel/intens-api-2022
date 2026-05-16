output "service_plan_id" {
  value = azurerm_service_plan.intensappplan.id
}

output "intens_web_app_id" {
  value = azurerm_linux_web_app.intenswebapp.identity[0].principal_id
}


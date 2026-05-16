variable "plan_name" {
    type = string
    default = "intens-app-plan"
} 

variable resource_group_location{
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "plan_os" {
    type = string
    default = "Linux"
}

variable "plan_sku" {
    type = string
    default = "F1"
}

variable "web_app_name" {
    type = string
    default = "webapp-intens"
}

variable "registry_container_image_name" {
    type = string
    default = "intenscontainer:latest"
}

variable "registry_container_url" {
    type = string
    default = "https://intenscontainer.azurecr.io"
}
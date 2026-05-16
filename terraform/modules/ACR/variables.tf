variable "container_name" {
    type = string
    default = "intenscontainer"
}

variable "container_resource_group_name" {
    type = string
    default = "default"
}

variable "container_location" {
    type = string
    default = "westeurope"
}

variable "container_sku" {
    type = string
    default = "Basic"
}
variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID used for resource scoping"
}

variable "resource_group_location" {
  type        = string
  default     = "westeurope"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "intens"
}

variable "container_sku" {
  type        = string
  default     = "Basic"
}

variable "container_name" {
  type        = string
}

variable "web_app_name" {
  type        = string
}

variable "plan_name" {
  type        = string
}

variable "plan_sku" {
  type        = string
  default     = "F1"
}

variable "registry_container_image_name" {
  type        = string
}
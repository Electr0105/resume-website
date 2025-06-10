variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "client_id" {
  type        = string
  description = "Service principal client ID"
}

variable "client_secret" {
  type        = string
  description = "Service principal client secret"
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory tenant ID"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}

variable "name" {
  type        = string
  description = "Generic name for resources"
}

variable "domain_name" {
  type        = string
  description = "Custom domain name"
}

variable "endpoint_url" {
  type        = string
  description = "Endpoint URL for resources"
}

variable "connection_string"{
  type        = string
  description = "Connection string for Storage Account"
}

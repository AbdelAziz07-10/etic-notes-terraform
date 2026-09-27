variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "costcenter" {
  description = "Cost center for billing and tracking"
  type        = string
}
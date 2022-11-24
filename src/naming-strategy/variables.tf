variable "region" {
  description = "Google project region"
}

variable "domain" {
  description = "The domain for the component e.g. Outbound, Inbound, Production etc"
}

variable "component" {
  description = "The name of the component"
}

variable "environment" {
  description = "Environment, the environment name such as 'stage', 'prod', 'dev', 'test'"
}

variable "resource_type" {
  default = "default"
}
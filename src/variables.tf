variable "region" {
  default     = "us-central1"
  description = "Google project region"
}

variable "domain" {
  default     = "outbound"
  description = "The domain for the component e.g. Outbound, Inbound, Production etc"
}

variable "component" {
  default     = "truck-load"
  description = "The name of the component"
}

variable "environment" {
  default     = "sandbox"
  description = "Environment, the environment name such as 'stage', 'prod', 'dev', 'test'"
}
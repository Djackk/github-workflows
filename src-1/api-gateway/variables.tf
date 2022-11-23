variable "region" {
  default     = "us-central1"
  description = "Google project region"
}

variable "prefix" {
  description = "The name prefix"
}

variable "api_gateway_service_account_id" {}

variable "api_config" {}

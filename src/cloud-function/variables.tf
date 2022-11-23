variable "region" {
  default     = "us-central1"
  description = "Google project region"
}

variable "prefix" {
  description = "The name prefix"
}

variable "function_name" {
  description = "Name of the function"
}

variable "service_account_id" {}

variable "source_zip_path" {}

variable "entry_point" {}

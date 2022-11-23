locals {
  cloud_function_name = var.function_name
}

#data "google_service_account" "service_account" {
#  account_id = var.service_account_id
#}

data "google_project" "project" {
}

resource "google_storage_bucket" "bucket" {
  name                        = "${data.google_project.project.name}-gcf-source" # Every bucket name must be globally unique
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  name   = "${local.cloud_function_name}.zip"
  bucket = google_storage_bucket.bucket.name
  source = var.source_zip_path
}

resource "google_cloudfunctions2_function" "function" {
  name        = join("-", [var.prefix, replace(local.cloud_function_name, ".", "")])
  location    = var.region
  description = "Truck load-orders API"

  build_config {
    runtime     = "go119"
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
#    service_account_email = data.google_service_account.service_account.email
  }
}






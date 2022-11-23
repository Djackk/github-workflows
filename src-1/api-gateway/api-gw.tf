locals {
  api_config_id_prefix = "api"
  api_id               = format("%s-api", var.prefix)
  gateway_id           = format("%s-gw", var.prefix)
  display_name         = local.api_id
  api_config_file_name = "api_config.yaml"
}

#data "google_service_account" "api_gw_service_account" {
#  account_id = var.api_gateway_service_account_id
#}

resource "google_api_gateway_api" "api_gw" {
  provider     = google-beta
  api_id       = local.api_id
  display_name = local.display_name
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider             = google-beta
  api                  = google_api_gateway_api.api_gw.api_id
  api_config_id_prefix = local.api_config_id_prefix
  display_name         = local.display_name

  openapi_documents {
    document {
      path     = local.api_config_file_name
      contents = base64encode(var.api_config)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "gw" {
  provider     = google-beta
  region       = var.region
  api_config   = google_api_gateway_api_config.api_cfg.id
  gateway_id   = local.gateway_id
  display_name = local.display_name
  depends_on   = [google_api_gateway_api_config.api_cfg]
}




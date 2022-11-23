locals {
  api_spec_file_path        = "files/truck-load-api.yaml"
  cloud_function_name       = "truck-load"
  cloud_function_version    = "1.0.2"
  api_gw_service_account_id = "hello-world-cloud-function-svc"
#  api_spec  = templatefile("${path.module}/${local.api_spec_file_path}", { function_uri = module.cloud_function.function_uri })
  # test
}

module "naming_strategy" {
  source      = "./naming-strategy"
  domain      = var.domain
  region      = var.region
  environment = var.environment
  component   = var.component
}

output "name" {
  value = module.naming_strategy.name
}

output "short_name" {
  value = module.naming_strategy.short_name
}

#module "cloud_function" {
#  source             = "./cloud-function"
#  entry_point        = "Function1"
#  function_name      = local.cloud_function_name
#  prefix             = module.naming_strategy.short_name
#  service_account_id = local.api_gw_service_account_id
#  source_zip_path    = "files/${local.cloud_function_name}-${local.cloud_function_version}.zip"
#}
#
#module "api_gateway" {
#  source                         = "./api-gateway"
#  prefix                         = module.naming_strategy.short_name
#  api_gateway_service_account_id = local.api_gw_service_account_id
#  api_config                     = local.api_spec
#}
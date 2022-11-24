locals {
  defaults = {
    delimiter = local.delimiter_lookup[var.resource_type]
  }
  short_domain_lookup = {
    outbound : "ob",
    inbound : "in"
  }
  delimiter_lookup = {
    role : "_",
    default : "-"
  }
  region_sub_strings = split("-", var.region)
  short_region = join("", [local.region_sub_strings[0],
    substr(local.region_sub_strings[1], 0, 1),
  substr(local.region_sub_strings[1], length(local.region_sub_strings[1]) - 1, length(local.region_sub_strings[1]))])
  short_domain = local.short_domain_lookup[var.domain]
  region       = var.resource_type == "role" ? replace(var.region, "-", "_") : var.region
  name         = join(local.defaults.delimiter, [var.environment, local.region, var.domain, var.component])
  short_name   = join(local.defaults.delimiter, [var.environment, local.short_region, local.short_domain, var.component])
}
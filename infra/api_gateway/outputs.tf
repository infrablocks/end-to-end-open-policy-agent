output "domain_name" {
  value = var.domain_name
}
output "hosted_zone_id" {
  value = var.hosted_zone_id
}
output "certificate_arn" {
  value = module.certificate.certificate_arn
}

output "api_gateway_rest_api_name" {
  value = module.api_gateway.api_gateway_rest_api_name
}

output "api_gateway_rest_api_id" {
  value = module.api_gateway.api_gateway_rest_api_id
}

output "api_gateway_rest_api_root_resource_id" {
  value = module.api_gateway.api_gateway_rest_api_root_resource_id
}

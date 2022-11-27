locals {
  stage_name = "default"
}

module "api_gateway" {
  source  = "infrablocks/api-gateway/aws"
  version = "2.0.0-rc.3"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier
}

module "log_permissions" {
  source  = "infrablocks/api-gateway/aws//modules/log_permissions"
  version = "2.0.0-rc.3"
}

module "api_gateway_lambda_integration" {
  source  = "infrablocks/api-gateway-lambda-integration/aws"
  version = "2.0.0-rc.2"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = module.api_gateway.api_gateway_rest_api_id
  api_gateway_rest_api_root_resource_id = module.api_gateway.api_gateway_rest_api_root_resource_id

  api_gateway_resource_definitions = [
    {
      path: "{proxy+}",
      method: "ANY",
    }
  ]

  lambda_function_name = data.terraform_remote_state.lambda.outputs.lambda_function_name
}

module "deployment" {
  source  = "infrablocks/api-gateway/aws//modules/deployment"
  version = "2.0.0-rc.3"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name = local.stage_name
  api_gateway_redeployment_triggers = module.api_gateway_lambda_integration.api_gateway_redeployment_triggers

  depends_on = [
    module.api_gateway,
    module.api_gateway_lambda_integration
  ]
}

module "domain" {
  source  = "infrablocks/api-gateway/aws//modules/domain"
  version = "2.0.0-rc.3"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name = local.stage_name
  api_gateway_domain_name = var.domain_name
  api_gateway_domain_name_certificate_arn = module.certificate.certificate_arn

  dns = {
    records: [
      {
        zone_id: var.hosted_zone_id
      }
    ]
  }

  depends_on = [
    module.api_gateway,
    module.deployment,
    module.certificate
  ]
}

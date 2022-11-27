module "lambda" {
  source = "infrablocks/lambda/aws"
  version = "2.0.0-rc.5"

  region = var.region

  component             = var.component
  deployment_identifier = var.deployment_identifier

  lambda_function_name = "${var.component}-${var.deployment_identifier}"
  lambda_description   = "Lambda for component: ${var.component}, with deployment identifier: ${var.deployment_identifier}"

  lambda_package_type = "Image"
  lambda_image_uri = local.image_uri

  lambda_memory_size = 512
}

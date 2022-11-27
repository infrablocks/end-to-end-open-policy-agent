module "repository" {
  source = "infrablocks/ecr-repository/aws"
  version = "2.1.0-rc.9"

  region = var.region

  component = var.component

  repository_name = var.repository_name
  repository_force_delete = true
  repository_image_tag_mutability = "MUTABLE"

  allow_in_account_lambda_pull_access = true
}

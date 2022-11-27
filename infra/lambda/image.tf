data "aws_ecr_image" "image" {
  repository_name = data.terraform_remote_state.repository.outputs.repository_name
  image_tag = var.image_tag
}

locals {
  image_uri = "${data.terraform_remote_state.repository.outputs.repository_url}@${data.aws_ecr_image.image.image_digest}"
}

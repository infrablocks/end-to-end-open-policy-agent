data "terraform_remote_state" "repository" {
  backend = "s3"

  config = {
    bucket = var.repository_state_bucket_name
    key = var.repository_state_key
    region = var.repository_state_bucket_region
    encrypt = var.repository_state_bucket_is_encrypted
  }
}

data "terraform_remote_state" "lambda" {
  backend = "s3"

  config = {
    bucket = var.lambda_state_bucket_name
    key = var.lambda_state_key
    region = var.lambda_state_bucket_region
    encrypt = var.lambda_state_bucket_is_encrypted
  }
}

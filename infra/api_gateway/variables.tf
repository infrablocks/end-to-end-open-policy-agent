variable "region" {
  description = "The region in which you want to create the API gateway."
}

variable "component" {
  description = "The name of the component or service for which this API gateway exists."
}
variable "deployment_identifier" {
  description = "A unique identifier for this deployment, used for tagging. Useful if you use this module many times."
}

variable "domain_name" {
  description = "The domain name to use for the API gateway."
}
variable "hosted_zone_id" {
  description = "The ID of the hosted zone in which to create DNS records for this API gateway."
}

variable "lambda_state_bucket_name" {
  description = "The name of the bucket holding lambda state."
}
variable "lambda_state_key" {
  description = "The key of the state object in the bucket."
}
variable "lambda_state_bucket_region" {
  description = "The region in which the bucket is located."
}
variable "lambda_state_bucket_is_encrypted" {
  description = "Whether or not the state bucket is encrypted."
  type        = bool
  default     = true
  nullable    = false
}

variable "region" {
  description = "The region in which you want to create the lambda."
}

variable "component" {
  description = "The name of the component or service that this lambda represents."
}
variable "deployment_identifier" {
  description = "A unique identifier for this deployment, used for tagging. Useful if you use this module many times."
}

variable "image_tag" {
  description = "The tag of the image to deploy to the lambda."
}

variable "repository_state_bucket_name" {
  description = "The name of the bucket holding repository state."
}
variable "repository_state_key" {
  description = "The key of the state object in the bucket."
}
variable "repository_state_bucket_region" {
  description = "The region in which the bucket is located."
}
variable "repository_state_bucket_is_encrypted" {
  description = "Whether or not the state bucket is encrypted."
  type        = bool
  default     = true
  nullable    = false
}

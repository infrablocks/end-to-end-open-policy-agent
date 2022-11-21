variable "region" {
  description = "The region in which you want to create the bucket."
}

variable "deployment_identifier" {
  description = "A unique identifier for this bucket, used for tagging. Useful if you use this module many times."
}

variable "state_bucket_name" {
  description = "Your desired bucket name."
}

variable "region" {
  description = "The region in which you want to create the bucket."
}

variable "deployment_identifier" {
  description = "A unique identifier for this bucket, used for tagging. Useful if you use this module many times."
}

variable "storage_bucket_name" {
  description = "Your desired bucket name for storing state and artifacts for this component."
}

variable "region" {
  description = "The region in which you want to create the ECR repository."
}

variable "component" {
  description = "The name of the component or service for which this ECR repository exists."
}

variable "repository_name" {
  description = "Your desired ECR repository name."
}

output "repository_name" {
  value = var.repository_name
}
output "repository_url" {
  value = module.repository.repository_url
}
output "registry_id" {
  value = module.repository.registry_id
}

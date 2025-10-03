output "repository_urls" {
  description = "Map of repository names to URLs"
  value       = { for k, v in aws_ecr_repository.microservices : k => v.repository_url }
}

output "repository_names" {
  description = "Map of repository names"
  value       = { for k, v in aws_ecr_repository.microservices : k => v.name }
}

output "registry_id" {
  description = "Registry ID"
  value       = values(aws_ecr_repository.microservices)[0].registry_id
}
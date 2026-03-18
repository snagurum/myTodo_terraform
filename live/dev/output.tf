
output "cdn_url" {
  value = module.spa.cdn_url
}

output "cdn_distribution_id" {
  value = module.spa.cdn_distribution_id
}

# output "cf-acm_validation_records" {
#   value = module.todo-cf-acm-cert.acm_validation_records
# }

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "cicd_role_arn" {
  value = module.github-oidc-role.role_arn
}

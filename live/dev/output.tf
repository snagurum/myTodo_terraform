output "cdn_url" {
  value = module.spa.cdn_url
}

output "cdn_distribution_id" {
  value = module.spa.cdn_distribution_id
}

output "acm_validation_records" {
  value = module.acm-cert.acm_validation_records
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

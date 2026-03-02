output "cdn_url" {
  value = module.spa.cdn_url
}

output "acm_validation_records" {
  value = module.acm-cert.acm_validation_records
}
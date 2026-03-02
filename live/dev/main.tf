
module "spa" {
  source               = "../../modules/spa"
  bucket_name          = var.todo_url
  domain_name_cert_arn = "module.acm-cert.acm_cert_arn"
}

module "acm-cert" {
  source           = "../../modules/core/acm"
  domain_name      = var.todo_url
  alt_domain_names = var.todo_alt_urls
  profile_name     = var.aws_profile
}


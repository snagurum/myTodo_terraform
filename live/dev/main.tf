
module "spa" {
  source               = "../../modules/spa"
  bucket_name          = var.todo_url
  domain_name_cert_arn = module.acm-cert.acm_cert_arn
}

module "acm-cert" {
  source           = "../../modules/core/acm"
  domain_name      = var.todo_url
  alt_domain_names = var.todo_alt_urls
  profile_name     = var.aws_profile
  use_hosted_zone  = true
}



data "aws_route53_zone" this {
  name = var.todo_url
  private_zone = false
}

resource "aws_route53_record" "root" {
    zone_id = data.aws_route53_zone.this.zone_id
    name    = var.todo_url
    type    = "A"

    alias {
    name                   = module.spa.spa_cdn.domain_name
    zone_id                = module.spa.spa_cdn.hosted_zone_id
    evaluate_target_health = false
    }
}

resource "aws_route53_record" "www" {
    zone_id = data.aws_route53_zone.this.zone_id
    name    = var.todo_alt_urls[0]
    type    = "A"

    alias {
    name                   = module.spa.spa_cdn.domain_name
    zone_id                = module.spa.spa_cdn.hosted_zone_id
    evaluate_target_health = false
    }
}

module "ecr" {
  source    = "../../modules/core/ecr"
  name      = var.todo_ecr_name
}


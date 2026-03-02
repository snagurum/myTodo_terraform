# terraform {
#   required_providers {
#     aws = {
#       source                = "hashicorp/aws"
#       configuration_aliases = [ aws ] # This allows the module to accept an aliased provider
#     }
#   }
# }


resource "aws_acm_certificate" "this" {
  provider                  = aws.use1
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.alt_domain_names
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  provider        = aws.use1
  count           = !var.use_hosted_zone ? 1 : 0
  certificate_arn = aws_acm_certificate.this.arn
  validation_record_fqdns = [
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.resource_record_name
  ]
}


output "acm_validation_records" {
  value = aws_acm_certificate.this.domain_validation_options
}

output "acm_cert_arn" {
  value = aws_acm_certificate.this.arn
}

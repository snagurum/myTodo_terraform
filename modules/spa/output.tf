output "cdn_url" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cdn_distribution_id" {
  value = aws_cloudfront_distribution.this.id
}

output "spa_cdn"{
  value = aws_cloudfront_distribution.this
}
output "key_arn" {
  value       = aws_kms_key.this.arn
  description = "The Amazon Resource Name (ARN) of the key"
}

output "key_id" {
  value       = aws_kms_key.this.key_id
  description = "The unique ID generated for the KMS key"
}

output "alias_arn" {
  value       = aws_kms_alias.this.arn
  description = "The Amazon Resource Name (ARN) of the key alias"
}
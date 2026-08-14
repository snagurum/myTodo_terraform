variable "name" {
  type        = string
  description = "Name for the KMS key"
}

variable "description" {
  type        = string
  description = "Description for what the KMS key is protecting"
  default     = "Managed by Terraform KMS module"
}

variable "alias_name" {
  type        = string
  description = "The display name for the KMS key alias (must start without 'alias/')"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Duration in days before the deleted key material is permanently destroyed"
  default     = 30
}

variable "enable_key_rotation" {
  type        = bool
  description = "Specifies whether automatic annual key rotation is enabled"
  default     = true
}

variable "key_administrators" {
  type        = list(string)
  description = "IAM user or role ARNs allowed to manage the KMS key"
  default     = []
}

variable "key_users" {
  type        = list(string)
  description = "IAM user, role, or service ARNs allowed to use the key for encryption/decryption"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Metadata tags to assign to the KMS resource"
  default     = {}
}

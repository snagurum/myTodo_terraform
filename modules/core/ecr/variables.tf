variable "name" {
  type = string
}

variable "backup_count" {
  type    = number
  default = 5
}

variable "image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}
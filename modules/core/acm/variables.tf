variable "profile_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "alt_domain_names" {
  type = list(string)
}

variable "use_hosted_zone" {
  type    = bool
  default = false
}
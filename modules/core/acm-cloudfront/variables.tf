variable "profile_name" {
  type = string
}

variable "hosted_zone_name" {
  type    = string
  default = null
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
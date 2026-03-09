
variable "vpc_id" {

}

variable "name" {
  default = "name"
}

variable "description" {
  default = "description"
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group"
  type = list(object({
    port            = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))
  default = [
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP access"
    },
    {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS access"
      }, {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH access"
    }
  ]
}

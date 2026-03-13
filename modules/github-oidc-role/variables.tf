variable "environment" {}
variable "project" {}

# variable "github_org" {}
# variable "github_repo" {}
variable "github_repos" {}
variable "branch" {
  default = "main"
}
variable "s3_bucket" {}
variable "oidc_provider_arn" {}
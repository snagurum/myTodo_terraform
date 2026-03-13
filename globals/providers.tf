terraform {
  backend "s3" {
    bucket = "mytodo-poc-terraform-state"
    key    = "global"
    region = "ap-south-1"
    # dynamodb_table = "your-dynamodb-table-name"
    # encrypt        = true
    profile = "me"
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}


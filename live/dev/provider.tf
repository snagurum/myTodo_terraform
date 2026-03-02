terraform {
  backend "s3" {
    bucket = "mytodo-poc-terraform-state" # Replace with your bucket name
    key    = "mytodo-poc"                 # Object path within the bucket
    region = "ap-south-1"                 # The region where the bucket resides
    # dynamodb_table = "your-dynamodb-table-name"    # Replace with your DynamoDB table name
    # encrypt        = true                          # Enables server-side encryption
    # Optionally specify a profile if not using default credentials or environment variables
    profile = "me"
  }
}

provider "aws" {
  region  = var.region
  profile = "me"

  default_tags {
    tags = {
      Environment = var.env
      Project     = var.project
    }
  }
}
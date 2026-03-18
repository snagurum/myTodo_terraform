terraform {
  backend "s3" {
    bucket = "mytodo-poc-terraform-state"
    key    = "dev-mytodo"
    region = "ap-south-1"
    # dynamodb_table = "your-dynamodb-table-name"
    # encrypt        = true
    profile = "me"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.2.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }

  required_version = ">= 1.13.4"
}



provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = var.env
      Project     = var.project
    }
  }
}


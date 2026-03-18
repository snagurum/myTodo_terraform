terraform {
  backend "s3" {
    bucket = "mytodo-poc-terraform-state"
    key    = "prod-mytodo"
    region = "ap-south-1"
    # dynamodb_table = "your-dynamodb-table-name"
    # encrypt        = true
    profile = "me"
  }

  required_providers {
    # Pinning hashicorp/aws to exactly v6.36.0
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
    # Pinning hashicorp/kubernetes to exactly v3.0.1
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    # Pinning hashicorp/helm to exactly v3.1.1
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    # Pinning hashicorp/time to exactly v0.13.1
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
    # Pinning hashicorp/tls to exactly v4.2.1
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


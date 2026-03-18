
locals {
  kube_config = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    cluster_name           = module.eks.cluster_name
  }
}

provider "kubernetes" {
  host                   = local.kube_config.host
  cluster_ca_certificate = local.kube_config.cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.kube_config.cluster_name, "--profile", var.aws_profile]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes = {
    host                   = local.kube_config.host
    cluster_ca_certificate = local.kube_config.cluster_ca_certificate
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.kube_config.cluster_name, "--profile", var.aws_profile]
      command     = "aws"
    }
  }
}


provider "kubectl" {
  host                   = local.kube_config.host
  cluster_ca_certificate = local.kube_config.cluster_ca_certificate
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", local.kube_config.cluster_name, "--profile", var.aws_profile]
  }
}
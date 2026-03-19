
variable "eks_cluster_name" {
  type = string
}

variable "eks_pod_identity_agent_version" {
  type = string
  #   default = "v1.0.0-eksbuild.1"
  default = "v1.3.10-eksbuild.1"
}

variable "identity_access_role_name" {
  type = string
}

variable "eks_namespace" {
  type = string
}

variable "eks_sa_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}


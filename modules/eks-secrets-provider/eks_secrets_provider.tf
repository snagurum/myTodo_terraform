terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      # Optional: version = ">= 1.14.0"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_name
}

data "aws_iam_openid_connect_provider" "oidc" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "helm_release" "secrets_store_csi_driver" {
  name      = "secrets-store-csi-driver"
  namespace = "kube-system"

  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"

  set = [{
    name  = "syncSecret.enabled"
    value = "true"
    }, {
    name  = "enableSecretRotation"
    value = "true"
    }, {
    name  = "providers.aws.enabled"
    value = "true"
  }]
}

resource "kubectl_manifest" "aws_provider" {
  for_each = {
    for index, doc in split("---", templatefile("${path.module}/aws-provider-installer.yaml", {})) :
    index => doc if trimspace(doc) != ""
  }
  yaml_body = each.value
}

# data "kubectl_file_documents" "aws_provider" {
#   content = file("${path.module}/aws-provider-installer.yaml")
# }

# resource "kubectl_manifest" "aws_provider" {
#   for_each  = data.kubectl_file_documents.aws_provider.manifests
#   yaml_body = each.value

#   depends_on = [
#     helm_release.secrets_store_csi_driver
#   ]
# }


resource "aws_iam_policy" "ssm_access" {
  name = "eks-ssm-parameter-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"

      Action = [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ]

      Resource = "arn:aws:ssm:ap-south-1:${data.aws_caller_identity.current.account_id}:parameter/${var.parameter_store_name}/*"
    }]
  })
}

resource "aws_iam_role" "ssm_irsa_role" {
  name = "eks-ssm-irsa-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(data.aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub" = "system:serviceaccount:${var.namespace}:${var.sa_prefix}-ssm-reader"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.ssm_irsa_role.name
  policy_arn = aws_iam_policy.ssm_access.arn
}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_service_account_v1" "ssm_reader" {

  metadata {
    name      = "${var.sa_prefix}-ssm-reader"
    namespace = var.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.ssm_irsa_role.arn
    }
  }
  depends_on = [kubernetes_namespace_v1.this]
}
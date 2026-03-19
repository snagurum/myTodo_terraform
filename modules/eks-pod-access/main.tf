resource "aws_eks_addon" "pod_identity" {
  cluster_name  = var.eks_cluster_name
  addon_name    = "eks-pod-identity-agent"
  addon_version = var.eks_pod_identity_agent_version
}

data "aws_iam_policy_document" "pod_identity_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole", "sts:TagSession"]
  }
}

resource "aws_iam_role" "s3_access_role" {
  name               = "${var.identity_access_role_name}-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json
}


resource "aws_iam_policy" "s3_full_bucket_access" {
  name        = "eks-s3-list-write-delete-policy"
  description = "Allows listing, uploading, and deleting in a specific bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowBucketLevelActions"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}"
        ]
      },
      {
        Sid    = "AllowObjectLevelActions"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/test/*",
          "arn:aws:s3:::${var.s3_bucket_name}/test"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "s3_read_only" {
  #   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  policy_arn = aws_iam_policy.s3_full_bucket_access.arn
  role       = aws_iam_role.s3_access_role.name
}

resource "aws_eks_pod_identity_association" "s3_association" {
  cluster_name    = var.eks_cluster_name
  namespace       = var.eks_namespace
  service_account = var.eks_sa_name
  role_arn        = aws_iam_role.s3_access_role.arn
  depends_on      = [aws_iam_role.s3_access_role, aws_iam_role_policy_attachment.s3_read_only]
}

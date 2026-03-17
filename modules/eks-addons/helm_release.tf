
resource "kubernetes_service_account_v1" "aws_lbc" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.aws_lb_controller_role_arn
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set = [{
    name  = "clusterName"
    value = var.eks_cluster_name
    }, {
    name  = "serviceAccount.create"
    value = "false"
    }, {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    }, {
    name  = "certificateArn"
    value = var.certificate_arn
    }, {
    name  = "listenPorts[0].HTTP"
    value = "80"
    }, {
    name  = "listenPorts[1].HTTPS"
    value = "443"
    }
  ]
  depends_on = [kubernetes_service_account_v1.aws_lbc]
}


resource "time_sleep" "wait_for_lbc" {
  depends_on      = [helm_release.aws_load_balancer_controller]
  create_duration = "30s"
}


resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  depends_on       = [time_sleep.wait_for_lbc]
}


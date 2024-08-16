resource "helm_release" "ingress-nginx" {
  name             = var.name
  chart            = var.helm_chart
  namespace        = var.namespace
  repository       = var.helm_repository
  version          = var.chart_version
  atomic           = var.atomic
  create_namespace = var.create_namespace
  wait             = var.wait
  timeout          = var.timeout

  values = [
    var.values_file
  ]

  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_class_name
  }
  set {
    name  = "controller.ingressClassResource.default"
    value = var.ingress_class_is_default
  }
  set {
    name  = "serviceAccount.create"
    value = var.is_service_account
  }
  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  # set {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = "${aws_iam_role.lbc_iam_role.arn}"
  # }

  depends_on = [var.eks_cluster]
}

resource "helm_release" "external_dns_same_account" {
  count = var.cross_account ? 0 : 1
  name             = "external-dns"
  chart            = "external-dns"
  namespace        = "private-ingress"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  version          = var.chart_version

  values = [
    var.values_file
  ]
  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_id # cluster-id
  }
  set {
    name  = "awsRegion"
    value = var.aws_region
  }
  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.externaldns_iam_role_same_account.0.arn}"
  }
  depends_on = [aws_iam_role.externaldns_iam_role_same_account ]
}



resource "helm_release" "external_dns_cross_account" {
  count = var.cross_account ? 1 : 0
  name             = "external-dns"
  chart            = "external-dns"
  namespace        = "private-ingress"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  version          = var.chart_version
  values = [
    var.values_file
  ]
  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_id # cluster-id
  }
  set {
    name  = "awsRegion"
    value = var.aws_region
  }
  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.externaldns_iam_role_cross_account.0.arn}"
  }
  depends_on = [aws_iam_role.externaldns_iam_role_cross_account ]
}

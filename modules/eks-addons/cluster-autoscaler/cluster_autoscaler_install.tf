# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [aws_iam_role.cluster_autoscaler_iam_role, var.eks_cluster_id]
  name       = "${var.account}-${var.name}-${var.environment}-cluster-as"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.chart_version # 9.26.0
  namespace  = "kube-system"
  values = var.values_file != "" ? [var.values_file] : []
  set {
    name  = "cloudProvider"
    value = "aws"
  }
  set {
    name  = "image.tag"
    value = var.image_tag #1.24.0
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
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }


  set {
    name  = "extraArgs.expander"
    value = "priority"
  }

  set {
    name = "expanderPriorities"
    value = <<EOF
    100:
      - ".*t3a.*SPOT.*"
    40:
      - ".*m6a.*SPOT.*"
    20:
      - ".*m5a.*SPOT.*"
    10:
      - ".*infra.*SPOT.*"
    1:
      - ".*"
EOF
  }
  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.cluster_autoscaler_iam_role.arn}"
  }
  # Additional Arguments (Optional) - To Test How to pass Extra Args for Cluster Autoscaler
  set {
    name  = "extraArgs.scan-interval"
    value = "20s"
  }
}
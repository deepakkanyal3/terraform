#**************************************************************************************************
# EKS Cluster
#**************************************************************************************************
# Resource: aws_eks_cluster
resource "aws_eks_cluster" "eks" {
  # Name of the cluster.
  name = "${var.account}-${var.name}-${var.environment}"

  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for 
  # the Kubernetes control plane to make calls to AWS API operations on your behalf
  role_arn                  = var.ekscluster_role_arn
  # Desired Kubernetes master version
  version                   = var.eks_version
  # Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = var.cluster_log_types

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster.id]
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = true
    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access  = false
    # Must be in at least two different availability zones [all 3 subnet]
    subnet_ids              = var.subnet_ids
  }
  # kubernetes_network_config {
  #   service_ipv4_cidr = var.cluster_service_ipv4_cidr
  # }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.amazon_eks_cluster_policy,
    aws_cloudwatch_log_group.eks_cluster_logs
  ]
  tags = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}-${var.name}-${var.environment}"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}

resource "aws_cloudwatch_log_group" "eks_cluster_logs" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  name              = "/aws/eks/${var.account}-${var.name}-${var.environment}/cluster"
  retention_in_days = var.log_retention

  # ... potentially other configuration ...
  tags = merge(

    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}-${var.name}-${var.environment}_cloudwatch_loggrp"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
  
}
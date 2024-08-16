#**************************************************************************************************
# EKS Cluster SG
#**************************************************************************************************
resource "aws_security_group" "eks_cluster" {
  name        = "${var.account}-${var.name}-${var.environment}_ControlPlaneSecurityGroup"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = var.vpc_id

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
      Name = "${var.account}-${var.name}-${var.environment}_ControlPlaneSecurityGroup"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}
resource "aws_security_group_rule" "cluster_inbound_https" {
  count = length(var.cluster_access_cidrs)
  description       = "Allow https connection from VPN"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster.id
  cidr_blocks       = [var.cluster_access_cidrs[count.index]]
  type              = "ingress"
}


resource "aws_security_group_rule" "cluster_inbound_node" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_cluster.id
  #security_group_id        = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id # [aws_security_group.eks_cluster.id]
  source_security_group_id = aws_security_group.eks_nodes.id
  type                     = "ingress"
}
resource "aws_security_group_rule" "cluster_outbound" {
  description              = "Allow unmanaged nodes to communicate with control plane (all ports)"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_cluster.id
  #security_group_id        = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  #security_group_id        = aws_security_group.eks_cluster.id # [aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id]
  source_security_group_id = aws_security_group.eks_nodes.id
  type                     = "egress"
}

#**************************************************************************************************
# EKS Node-Group SG
#**************************************************************************************************
resource "aws_security_group" "eks_nodes" {
  name        = "${var.account}-${var.name}-${var.environment}_ClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = var.vpc_id

  # ingress {
  #   from_port       = 0
  #   to_port         = 0
  #   protocol        = "-1"
  #   security_groups = [aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
      Name = "${var.account}-${var.name}-${var.environment}_ClusterSharedNodeSecurityGroup"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"],
    ]
  }
}
resource "aws_security_group_rule" "self" {
  description       = "Allow all traffic for self"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_nodes.id
  self              = true
  type              = "ingress"
}
# resource "aws_security_group_rule" "cluster_to_node_all" {
#   description              = "Allow all traffic from cluster"
#   from_port                = 0
#   to_port                  = 0
#   protocol                 = "-1"
#   security_group_id        = aws_security_group.eks_nodes.id
#   #source_security_group_id = var.cluster_sg
#   source_security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
#   type                     = "ingress"
# }
resource "aws_security_group_rule" "nodes_inbound" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  #source_security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_security_group.eks_cluster.id
  type                     = "ingress"
}
#**************************************************************************************************
# EKS Node-Group
#**************************************************************************************************
# Node-Group-On-demand
resource "aws_eks_node_group" "nodes_all" {
  # Name of the EKS Cluster.
  cluster_name         = "${var.account}-${var.name}-${var.environment}"
  # Name of the EKS Node Group.
  node_group_name      = "${var.account}-${var.node_group_name}-${var.environment}-${var.node_capacity}"
  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn        = var.eks_iam.ng-role-arn
  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids           = var.subnet_ids
  # taint {
  #   #   key    = "team"
  #   #   value  = "devops"
  #   #   effect = "NO_SCHEDULE"
  #   # }
  # Machine Configuration
  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: [AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64]
  ami_type             = var.node_ami_type
  #release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  # Kubernetes version
  #version = var.eks_version
  # Type of capacity associated with the EKS Node Group. [Valid values: ON_DEMAND, SPOT]
  capacity_type        = var.node_capacity
  # Disk size in GiB for worker nodes
  #disk_size = var.node_disk_size
  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false
  # List of instance types associated with the EKS Node Group
  instance_types       = var.node_instance_types
  # Launch Template reference
  launch_template {
    name    = aws_launch_template.lt-ng1.name
    version = var.lt_version
  }
  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = var.node_desired_size
    # Maximum number of worker nodes.
    max_size     = var.node_max_size
    # Minimum number of worker nodes.
    min_size     = var.node_min_size
  }
  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = var.node_max_unavailable
  }
  labels = var.node_group_labels

  dynamic "taint" {
    for_each = var.allow_taints ? var.node_taints : []
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.eks_iam,
    aws_launch_template.lt-ng1
    #var.k8s_aws-auth_configmap
  ]


  # Allow external changes without Terraform plan difference
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
      Name = "${var.account}-${var.node_group_name}-${var.environment}_ng_${var.node_capacity}"
    },
    {
      "k8s.io/cluster-autoscaler/${var.account}-${var.name}-${var.environment}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"             = "TRUE"
    }
  )
  lifecycle {
    create_before_destroy = false
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"], scaling_config[0].desired_size
    ]
  }
}
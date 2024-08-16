resource "aws_launch_template" "lt-ng1" {
  #instance_type           = var.node_instance_types
  #key_name                = data.terraform_remote_state.iam.outputs.key_name
  name                   = format("lt-%s-%s-ng1", var.node_capacity, "${var.account}-${var.node_group_name}-${var.environment}")
  description            = "Launch Template for EKS Managed Node Groups"
  #image_id                = data.aws_ssm_parameter.eksami.value
  #user_data               = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids = [var.eks_cluster.node-sg]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.account}-${var.node_group_name}-${var.environment}-${var.node_capacity}"
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
      Account         = var.account
      Environment     = var.environment
    }
  }
  tags                   = merge(

    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    },
    {
      Name = "${var.account}-${var.node_group_name}-${var.environment}_lt_ng_${var.node_capacity}"
    }
  )
  lifecycle {
    create_before_destroy = false
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"], tag_specifications["tags"]
    ]
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.node_disk_size
      volume_type = "gp3"
    }
  }

}
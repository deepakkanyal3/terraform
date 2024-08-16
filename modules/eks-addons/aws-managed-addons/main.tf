resource "aws_eks_addon" "addons" {
  for_each          = {for addon in var.addons : addon.name => addon}
  cluster_name      = var.eks_cluster_id
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = "OVERWRITE"
  # Allow external changes without Terraform plan difference
  tags              = merge(
    var.tags,
    {
      Account         = var.account
      Environment     = var.environment
      CreatedBy       = data.aws_caller_identity.current.user_id
      CreatedByArn    = data.aws_caller_identity.current.arn
      LaunchMonthYear = formatdate("MMM-YYYY", timestamp())
    }
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      # Ignore changes to tags
      tags["CreatedBy"], tags["CreatedByArn"], tags["LaunchMonthYear"]
    ]
  }
}
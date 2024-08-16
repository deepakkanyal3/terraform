
output "ng_name" {
  value = aws_eks_node_group.nodes_all.node_group_name
}

output "ng_arn" {
  value = aws_eks_node_group.nodes_all.arn
}

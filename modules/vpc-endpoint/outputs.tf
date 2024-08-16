output "vpc_endpoint_security_group_id" {
  description = "The ID of the VPC endpoint security group"
  value       = aws_security_group.vpc_endpoint.id
}

output "vpc_gateway_endpoint_ids" {
  description = "The IDs of the VPC gateway endpoints"
  value       = [for endpoint in aws_vpc_endpoint.vpc_gateway_endpoint : endpoint.id]
}

output "vpc_interface_endpoint_ids" {
  description = "The IDs of the VPC interface endpoints"
  value       = [for endpoint in aws_vpc_endpoint.vpc_interface_endpoint : endpoint.id]
}

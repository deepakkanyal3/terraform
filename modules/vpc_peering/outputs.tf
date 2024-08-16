output acceptor_route_tables {
  value       = data.aws_route_tables.acceptor.ids
}

output acceptor_route_tables_final {
  value       = local.acceptor_route_tables
}


output requestor_route_tables {
  value       = data.aws_route_tables.requestor.ids
}

output requestor_route_tables_final {
  value       = local.requestor_route_tables
}

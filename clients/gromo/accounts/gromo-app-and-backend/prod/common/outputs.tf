output acceptor_route_tables {
  value       = module.vpc-peering-account.acceptor_route_tables
}

output acceptor_route_tables_final {
  value       = module.vpc-peering-account.acceptor_route_tables_final
}


output requestor_route_tables {
  value       = module.vpc-peering-account.requestor_route_tables
}

output requestor_route_tables_final {
  value       = module.vpc-peering-account.requestor_route_tables_final
}

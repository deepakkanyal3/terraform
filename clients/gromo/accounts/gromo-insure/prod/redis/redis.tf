#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-elasticache-enable-in-transit-encryption
#tfsec:ignore:aws-ec2-add-description-to-security-group
#tfsec:ignore:aws-ec2-add-description-to-security-group-rule
module "redis" {
  source = "../../../../../../modules/elasticcache"
  vpc_id = data.aws_vpc.current_vpc.id
  node_type = "cache.t4g.micro"
  name = "redis"
  transit_encryption_enabled = false
  num_node_groups = 1
  num_cache_clusters = 1
  automatic_failover_enabled = true
  cluster_mode_enabled = true
  snapshot_retention_limit = 0
  subnet_ids = [data.aws_subnet.intra_subnet_a.id, data.aws_subnet.intra_subnet_b.id]
  tags                   = local.common_tags
  account = var.account
  environment = var.environment
  security_group_ids = [module.sg-redis.sg-id]

  parameter = [
    {
      name  = "cluster-enabled"
      value = "yes"
    }
  ]
}


module "redis_Central-resource-locking-universal" {
  source = "../../../../../../modules/elasticcache"
  vpc_id = data.aws_vpc.current_vpc.id
  node_type = "cache.t4g.micro"
  name = "crl-universal"
  transit_encryption_enabled = false
  num_node_groups = 1
  num_cache_clusters = 1
  automatic_failover_enabled = true
  cluster_mode_enabled = true
  snapshot_retention_limit = 0
  subnet_ids = [data.aws_subnet.intra_subnet_a.id, data.aws_subnet.intra_subnet_b.id]
  tags                   = local.common_tags
  account = var.account
  environment = var.environment
  security_group_ids = [module.sg-redis.sg-id]

  parameter = [
    {
      name  = "cluster-enabled"
      value = "yes"
    }
  ]
}

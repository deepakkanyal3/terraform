terraform {
  required_providers {
    nexus = {
      source = "datadrivers/nexus"
      version = "2.2.0"
    }
  }
}

# helm proxy repo 
resource "nexus_repository_helm_proxy" "kubernetes_charts" {
  for_each = var.helm-proxy-repositories
  name   = each.value.name
  online = true

  storage {
    blob_store_name                = "default"
    strict_content_type_validation = true
  }

  proxy {
    remote_url       = each.value.remote_url
    content_max_age  = 1440
    metadata_max_age = 1440
  }

  negative_cache {
    enabled = true
    ttl     = 1440
  }

  http_client {
    blocked    = false
    auto_block = true
  }
  depends_on = [nexus_blobstore_s3.helm_s3_blob_store]
}
#helm proxy blob store
resource "nexus_blobstore_s3" "helm_s3_blob_store" {
  for_each = var.helm-proxy-repositories

  name              = each.value.name
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = each.value.name
      expiration = "-1"
    }
  }
}


# docker proxy repo and hosted repo 
resource "nexus_blobstore_s3" "s3_blob_store" {
  for_each = var.proxy-repositories

  name              = each.value.name
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = each.value.name
      expiration = "-1"
    }
  }
}
#docker group blob store
resource "nexus_blobstore_s3" "group_s3_blob_store" {

  name              = var.group_blob_store_name
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = var.group_blob_store_name
      expiration = "-1"
    }
  }
}
#docker hoster repo blob store
resource "nexus_blobstore_s3" "dockerhosted_s3_blob_store" {
  count = var.create_hosted_repo ? 1 : 0
  name              = "dockerhosted"
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = "dockerhosted"
      expiration = "-1"
    }
  }
}
# docker hub proxy blob stores
resource "nexus_blobstore_s3" "dockerhub_s3_blob_store" {
  name              = var.docker_hub_proxy_name
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = var.docker_hub_proxy_name
      expiration = "-1"
    }
  }
}
#docker hub proxy repo
resource "nexus_repository_docker_proxy" "docker_hub_proxy" {
  name   = var.docker_hub_proxy_name
  online = true

  docker {
    force_basic_auth = false
    v1_enabled       = true
    
    http_port        = var.docker_hub_proxy_http_port
  }

  docker_proxy {
    index_type = "HUB"
  }

  storage {
    blob_store_name                = var.docker_hub_proxy_name
    strict_content_type_validation = true
  }

  proxy {
    remote_url       = var.docker_hub_proxy_remote_url
    content_max_age  = 1440
    metadata_max_age = 1440
  }

  negative_cache {
    enabled = true
    ttl     = 1440
  }

  http_client {
    blocked    = false
    auto_block = true
  }
depends_on = [nexus_blobstore_s3.dockerhub_s3_blob_store]
}
# docker proxy repo creation 
resource "nexus_repository_docker_proxy" "docker_proxy" {
  for_each = var.proxy-repositories

  name   = each.value.name
  online = true

  docker {
    force_basic_auth = false
    v1_enabled       = true
    
    http_port        = each.value.http_port
  }

  docker_proxy {
    index_type = "REGISTRY"
  }

  storage {
    blob_store_name                = each.value.name
    strict_content_type_validation = true
  }

  proxy {
    remote_url       = each.value.remote_url
    content_max_age  = 1440
    metadata_max_age = 1440
  }

  negative_cache {
    enabled = true
    ttl     = 1440
  }

  http_client {
    blocked    = false
    auto_block = true
  }
depends_on = [nexus_blobstore_s3.s3_blob_store]
}
#helm hosted repo
resource "nexus_repository_helm_hosted" "helm-hosted-repo" {
  count = var.create_helmhosted_repo ? 1 : 0
  name   = "helm-hosted-repo"
  online = true

  storage {
    blob_store_name                = "helm-hosted-repo"
    strict_content_type_validation = true
    write_policy                   = "ALLOW"
  }
}
resource "nexus_blobstore_s3" "helmhosted_s3_blob_store" {
  count = var.create_helmhosted_repo ? 1 : 0
  name              = "helm-hosted-repo"
  bucket_configuration {
    bucket {
      name   = var.s3_bucket
      region = var.s3_region
      prefix = "helm-hosted-repo"
      expiration = "-1"
    }
  }
  depends_on = [nexus_blobstore_s3.helmhosted_s3_blob_store] 
}

#creating docker hosted repo
resource "nexus_repository_docker_hosted" "dockerhosted" {
  count = var.create_hosted_repo ? 1 : 0
  name   = "dockerhosted"
  online = true

  docker {
    force_basic_auth = false
    v1_enabled       = true
    http_port        = var.dockerhosted_http_port
  }

  storage {
    blob_store_name                = "dockerhosted"
    strict_content_type_validation = true
    write_policy                   = "ALLOW"
  }
depends_on = [nexus_blobstore_s3.dockerhosted_s3_blob_store] 
}
# docker group with docker hosted repo + docker proxy repo
resource "nexus_repository_docker_group" "group-with-docker-hosted" {
  count = var.create_hosted_repo ? 1 : 0
  name   = "docker-group-repo"
  online = true

  docker {
    force_basic_auth = false
    http_port        = var.group-http-port
    v1_enabled       = true
  }

  group {
  
    member_names = concat([nexus_repository_docker_hosted.dockerhosted[0].name], [nexus_repository_docker_proxy.docker_hub_proxy.name], [for repo in keys(nexus_repository_docker_proxy.docker_proxy) : nexus_repository_docker_proxy.docker_proxy[repo].name])

  }
  storage {
    blob_store_name                = var.group_blob_store_name
    strict_content_type_validation = true
  }
depends_on = [nexus_repository_docker_proxy.docker_proxy,nexus_blobstore_s3.group_s3_blob_store,nexus_repository_docker_hosted.dockerhosted]
}
# docker group with only docker proxy repo
resource "nexus_repository_docker_group" "group-without-docker-hosted" {
  count = var.create_hosted_repo ? 0 : 1
  name   = "docker-group-repo"
  online = true
  docker {
    force_basic_auth = false
    http_port        = var.group-http-port
    v1_enabled       = true
  }
  group {
    member_names = concat([nexus_repository_docker_proxy.docker_hub_proxy.name], [for repo in keys(nexus_repository_docker_proxy.docker_proxy) : nexus_repository_docker_proxy.docker_proxy[repo].name])  
    }
  storage {
    blob_store_name                = "docker-group-repo"
    strict_content_type_validation = true
  }
depends_on = [nexus_repository_docker_proxy.docker_proxy,nexus_blobstore_s3.group_s3_blob_store]
}


output docker_proxy {
  value       = [for repo in keys(nexus_repository_docker_proxy.docker_proxy) : nexus_repository_docker_proxy.docker_proxy[repo].name]
}

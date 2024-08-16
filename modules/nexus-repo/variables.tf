variable "proxy-repositories" {
  description = "A map of repository configurations"
  type = map(object({
    name             = string
    http_port        = number
    remote_url       = string
  }))
}
variable "helm-proxy-repositories" {
  description = "A map of repository configurations"
  type = map(object({
    name             = string
    remote_url       = string
  }))
}
variable "create_hosted_repo" {
  description = "Flag to control whether to create the hosted repository and its blob store"
  type        = bool
  default = false
}
variable "create_helmhosted_repo" {
  description = "Flag to control whether to create the hosted repository and its blob store"
  type        = bool
  default = false
}

variable "group-http-port" {
  type        = number
}
variable "group_blob_store_name" {
  type        = string
}
variable "s3_bucket" {
  type        = string
}
variable "s3_region" {
  type        = string
  default     = "ap-south-1"
}
variable "dockerhosted_http_port" {
  type  = number
}
#docker hub proxy variables
variable "docker_hub_proxy_name" {
  type        = string
  default = "docker-hub-proxy"
}
variable "docker_hub_proxy_http_port" {
  type        = number
  default = 8085
}
variable "docker_hub_proxy_remote_url" {
  type        = string
  default = "https://registry-1.docker.io"
}
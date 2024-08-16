variable "nexus_url" {
  type    = string
  default = "https://nexus.iopshub.com"
}
variable "nexus_username" {
  type    = string
  default = "admin"
}
variable "nexus_password" {
  type    = string
  default = "Q5NUWOV9ZeEQxnf"
}
variable "create_hosted_repo" {
  description = "Flag to control whether to create the docker hosted repository and its blob store"
  type        = bool
  default     = true
}
variable "create_helmhosted_repo" {
  description = "Flag to control whether to create the helm hosted repository and its blob store"
  type        = bool
  default     = true
}
variable "group-http-port" {
  type    = number
  default = 8090
}
variable "group_blob_store_name" {
  type        = string
  default     = "docker-group-blob-store"
}
variable "dockerhosted_http_port" {
  type  = number
  default = 5000
}
variable "s3_bucket" {
  type        = string
  default     = "iopshub-nexus-prod"
}
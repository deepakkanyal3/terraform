variable "vpc_id" {

}
variable "subnet_ids" {

}
variable "domain_name" {

}
variable "edition" {
  default = "Standard"
}
data "aws_caller_identity" "current" {}
variable "type" {
  default = "MicrosoftAD"
}
variable "password" {
  default = "SuperSecretPassw0rd"
}
variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}
variable "account" {
  description = "default account"
  type        = string
}
variable "environment" {
  description = "default env"
  type        = string

}
variable "ami" {
}
variable "instance_type" {}
variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}
module "default_sqs" {
  source = "../../../../../../modules/sqs"

  name = var.sqs
  environment = var.environment
  account     = var.account
  consumer    = var.sqs
  producer    = var.sqs
  sqs_managed_sse_enabled = false
}

module "default_sqs1" {
  source = "../../../../../../modules/sqs"

  name = var.sqs1
  environment = var.environment
  account     = var.account
  consumer    = var.sqs1
  producer    = var.sqs1
  sqs_managed_sse_enabled = false
}

module "default_sqs2" {
  source = "../../../../../../modules/sqs"

  name = var.sqs2
  environment = var.environment
  account     = var.account
  consumer    = var.sqs2
  producer    = var.sqs2
  sqs_managed_sse_enabled = false
}

module "default_sqs3" {
  source = "../../../../../../modules/sqs"

  name = var.sqs3
  environment = var.environment
  account     = var.account
  consumer    = var.sqs3
  producer    = var.sqs3
  sqs_managed_sse_enabled = false
}

module "fifo_sqs" {
  source = "../../../../../../modules/sqs"

  name = var.sqs4
  environment = var.environment
  account     = var.account
  consumer    = var.sqs4
  producer    = var.sqs4
  sqs_managed_sse_enabled = false
  fifo_queue = true
}
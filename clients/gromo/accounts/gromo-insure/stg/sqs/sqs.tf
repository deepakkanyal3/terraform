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

module "default_sqs4" {
  source = "../../../../../../modules/sqs"

  name = var.sqs4
  environment = var.environment
  account     = var.account
  consumer    = var.sqs4
  producer    = var.sqs4
  sqs_managed_sse_enabled = false
}

module "default_sqs5" {
  source = "../../../../../../modules/sqs"

  name = var.sqs5
  environment = var.environment
  account     = var.account
  consumer    = var.sqs5
  producer    = var.sqs5
  sqs_managed_sse_enabled = false
}

module "default_sqs6" {
  source = "../../../../../../modules/sqs"

  name = var.sqs6
  environment = var.environment
  account     = var.account
  consumer    = var.sqs6
  producer    = var.sqs6
  sqs_managed_sse_enabled = false
}

module "default_sqs7" {
  source = "../../../../../../modules/sqs"

  name = var.sqs7
  environment = var.environment
  account     = var.account
  consumer    = var.sqs7
  producer    = var.sqs7
  sqs_managed_sse_enabled = false
}

module "default_sqs8" {
  source = "../../../../../../modules/sqs"

  name = var.sqs8
  environment = var.environment
  account     = var.account
  consumer    = var.sqs8
  producer    = var.sqs8
  sqs_managed_sse_enabled = false
}

module "default_sqs9" {
  source = "../../../../../../modules/sqs"

  name = var.sqs9
  environment = var.environment
  account     = var.account
  consumer    = var.sqs9
  producer    = var.sqs9
  sqs_managed_sse_enabled = false
}

module "default_sqs10" {
  source = "../../../../../../modules/sqs"

  name = var.sqs10
  environment = var.environment
  account     = var.account
  consumer    = var.sqs10
  producer    = var.sqs10
  sqs_managed_sse_enabled = false
}

module "default_sqs11" {
  source = "../../../../../../modules/sqs"

  name = var.sqs11
  environment = var.environment
  account     = var.account
  consumer    = var.sqs11
  producer    = var.sqs11
  sqs_managed_sse_enabled = false
}

module "default_sqs12" {
  source = "../../../../../../modules/sqs"

  name = var.sqs12
  environment = var.environment
  account     = var.account
  consumer    = var.sqs12
  producer    = var.sqs12
  sqs_managed_sse_enabled = false
}

module "default_sqs13" {
  source = "../../../../../../modules/sqs"

  name = var.sqs13
  environment = var.environment
  account     = var.account
  consumer    = var.sqs13
  producer    = var.sqs13
  sqs_managed_sse_enabled = false
}

module "default_sqs14" {
  source = "../../../../../../modules/sqs"

  name = var.sqs14
  environment = var.environment
  account     = var.account
  consumer    = var.sqs14
  producer    = var.sqs14
  sqs_managed_sse_enabled = false
}

module "default_sqs15" {
  source = "../../../../../../modules/sqs"

  name = var.sqs15
  environment = var.environment
  account     = var.account
  consumer    = var.sqs15
  producer    = var.sqs15
  sqs_managed_sse_enabled = false
}

module "default_sqs16" {
  source = "../../../../../../modules/sqs"

  name = var.sqs16
  environment = var.environment
  account     = var.account
  consumer    = var.sqs16
  producer    = var.sqs16
  sqs_managed_sse_enabled = false
}

module "default_sqs17" {
  source = "../../../../../../modules/sqs"

  name = var.sqs17
  environment = var.environment
  account     = var.account
  consumer    = var.sqs17
  producer    = var.sqs17
  sqs_managed_sse_enabled = false
}

module "default_sqs18" {
  source = "../../../../../../modules/sqs"

  name = var.sqs18
  environment = var.environment
  account     = var.account
  consumer    = var.sqs18
  producer    = var.sqs18
  sqs_managed_sse_enabled = false
}

module "default_sqs19" {
  source = "../../../../../../modules/sqs"

  name = var.sqs19
  environment = var.environment
  account     = var.account
  consumer    = var.sqs19
  producer    = var.sqs19
  sqs_managed_sse_enabled = false
}

module "default_sqs20" {
  source = "../../../../../../modules/sqs"

  name = var.sqs20
  environment = var.environment
  account     = var.account
  consumer    = var.sqs20
  producer    = var.sqs20
  sqs_managed_sse_enabled = false
}

module "fifo_sqs" {
  source = "../../../../../../modules/sqs"

  name = var.sqs21
  environment = var.environment
  account     = var.account
  consumer    = var.sqs21
  producer    = var.sqs21
  sqs_managed_sse_enabled = false
  fifo_queue = true
}
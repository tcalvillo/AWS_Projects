data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "vault_generic_secret" "aws" {
  path = "projects/aws/sts/${var.bl}-${var.appstackcode}-${var.environment}"
}

data "aws_partition" "current" {}
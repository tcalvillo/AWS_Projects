# Most of these variables can be defined by GitLab CI variables. Defaults are configured for development environment.
variable "environment" {}  # development | staging | production
variable "env" {}          # dev | stg | prd
variable "appstackcode" {} # from $CI_PROJECT_NAMESPACE
variable "bl" {}           # from $BUSINESSLINE
variable "projectcode" {}  # from $PROJECTCODE
variable "owner" {}        # from $OWNER
variable "project_name" {}
variable "default_region" {}
variable "aws_env" {}
variable "branch_name" {}
variable "job_jwt" {
  default = "null"
}

variable "teamproject" {}


variable "logs_s3_retention_region" {
  type = number
  default = 7
  description = "The number of days that we keep the logs in regional bucket"
}

variable "logs_s3_retention_central" {
  type = number
  default = 548
  description = "The number of days that we keep the logs in central bucket"
}

variable "shortEnv" {
  type = string
  default = ""
}

variable "project_current_name" {
  type = string
}

variable "ou_id" {
  type = string
}

variable "is_gov" {
  description = "Set to true to deploy the resource in AWS US Gov"
  type        = bool
  default     = false
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-1"
}

variable "role_count" {
  default = 1
}

variable "account_id" {
  description = "The AWS account ID where resources will be created"
  type        = string
  default     = "123456789012"   # NOTE: removed real one for security reasons
}
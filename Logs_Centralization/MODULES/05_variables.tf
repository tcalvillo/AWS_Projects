
variable "aws_env" {
  type = string
}

variable "shortEnv" {
  type = string
}

variable "logs_s3_retention" {
  type = number
}

variable "appstackcode" {
  type = string
}

variable "ou_id" {
  type = string
}

variable "central_bucket" {}

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
  default     = "123456789012" # NOTE: I replaced the correct one for security reasons
}

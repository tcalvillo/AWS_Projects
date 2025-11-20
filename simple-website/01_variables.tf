
variable "shortEnv" {
  type = string
}

variable "appstackcode" {
  type = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "The AWS account ID where resources will be created"
  type        = string
  # NOTE: Use environment variables on your laptop for default value
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type = string
    # NOTE: Use environment variables on your laptop for default value
}

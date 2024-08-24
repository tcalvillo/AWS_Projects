
variable "aws_env" {
  type = string
}

variable "shortEnv" {
  type = string
}

variable "appstackcode" {
  type = string
}

variable "ou_id" {
  type = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "role_count" {
  default = 1
}

variable "account_id" {
  description = "The AWS account ID where resources will be created"
  type        = string
  default     = "123456789012" # NOTE: I replaced the correct one for security reasons
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type = string
    default = "my-simple-website-bucket"
}


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

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    # NOTE: Use environment variables on your laptop for default value
}

variable "subnet_cidr_blocks" {
    description = "CIDR blocks for the subnets"
    type = list(string)
    # NOTE: Use environment variables on your laptop for default value
}

variable "availability_zones" {
    description = "Availability zones for the subnets"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
}



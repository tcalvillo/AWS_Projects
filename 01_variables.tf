
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
  default     = "123456789012" # NOTE: I replaced the correct one for security reasons
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/22"  # Usable Host IP Range 10.0.0.1 - 10.0.3.254 -> Tot. 1,024
}

variable "subnet_cidr_blocks" {
    description = "CIDR blocks for the subnets"
    type = list(string)
    default = [ "10.0.0.0/23", "10.0.2.0/23" ]  # 10.0.0.0/23 (10.0.0.0 to 10.0.1.255); 10.0.2.0/23 (10.0.2.0 to 10.0.3.255)
}

variable "availability_zones" {
    description = "Availability zones for the subnets"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
}



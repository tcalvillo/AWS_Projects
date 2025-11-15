terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.regions[0]  # us-east-1
  alias  = "primary"
}

provider "aws" {
  region = var.regions[1]  # us-west-1
  alias  = "secondary"
}

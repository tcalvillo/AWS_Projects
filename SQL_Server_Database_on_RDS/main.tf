
# NOTE: When you run terraform plan use-> terraform plan -out=tfplan
# This command creates a binary file named tfplan containing the execution plan
# This will generate a plan and save it to a file
# Review the plan by running-> terraform show tfplan
# Then, if all is fine, apply it by using-> terraform apply tfplan

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary provider (us-east-1)
provider "aws" {
  region = var.regions[0]  # e.g., "us-east-1"
  alias  = "primary"
}

# Secondary provider (us-west-1)
provider "aws" {
  region = var.regions[1]  # e.g., "us-west-1"
  alias  = "secondary"
}

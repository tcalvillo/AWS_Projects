
# Defines the resources needed for the VPC

provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block

    tags = {
      Name = "main-vpc"
    }
}

resource "aws_subnet" "main" {
    count = length(var.subnet_cidr_blocks)

    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_blocks[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
      Name = "main-subnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "main-igw"
    }
}

resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
      Name = "main-route-table"
    }
}

resource "aws_route_table_association" "main" {
    count = length(var.subnet_cidr_blocks)

    subnet_id = aws_subnet.main[count.index].id
    route_table_id = aws_route_table.main.id
}




 




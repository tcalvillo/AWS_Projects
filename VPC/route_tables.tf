
# Main VPC Public Route Table
resource "aws_route_table" "public_main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_main.id
  }
  tags = {
    Name = "Public-RT-Main"
  }
}

# Main VPC Private Route Tables
resource "aws_route_table" "private_main" {
  count  = 2
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_main[count.index].id
  }
  tags = {
    Name = "Private-RT-Main-${count.index + 1}"
  }
}

# Secondary VPC Public Route Table
resource "aws_route_table" "public_secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_secondary.id
  }
  tags = {
    Name = "Public-RT-Secondary"
  }
}

# Secondary VPC Private Route Tables
resource "aws_route_table" "private_secondary" {
  provider = aws.secondary
  count    = 2
  vpc_id   = aws_vpc.secondary.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_secondary[count.index].id
  }
  tags = {
    Name = "Private-RT-Secondary-${count.index + 1}"
  }
}

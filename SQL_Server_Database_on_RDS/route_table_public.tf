
# Manages traffic routing for public subnets, route to Internet Gateway

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"  # All outbound traffic goes to the Internet Gateway
    gateway_id = aws_internet_gateway.igw_main.id
  }
  tags = {
    Name = "Public-Route-Table"
  }
}

# Associate the public route table with the public subnets
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


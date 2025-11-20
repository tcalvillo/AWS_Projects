
resource "aws_eip" "nat_eip" {
  count = 2
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  count         = 2
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NAT-GW-${count.index + 1}"
  }
}

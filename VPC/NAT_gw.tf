
resource "aws_nat_gateway" "nat_gw_main" {
  count         = 2
  allocation_id = aws_eip.nat_elastic_ip_main[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NAT-GW-Main-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat_gw_secondary" {
  provider    = aws.secondary
  count       = 2
  allocation_id = aws_eip.nat_elastic_ip_secondary[count.index].id
  subnet_id     = aws_subnet.public_secondary[count.index].id
  tags = {
    Name = "NAT-GW-Secondary-${count.index + 1}"
  }
}

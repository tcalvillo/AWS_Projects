
resource "aws_route" "secondary_vpc_private_to_tgw" {
  depends_on               = [aws_ec2_transit_gateway.main]  # Explicit dependency
  provider                 = aws.secondary
  route_table_id           = aws_route_table.private_secondary[0].id
  destination_cidr_block   = aws_vpc.main.cidr_block
  transit_gateway_id       = aws_ec2_transit_gateway.main.id
}

resource "aws_route" "secondary_vpc_private_to_tgw_2" {
  depends_on               = [aws_ec2_transit_gateway.main]  # Explicit dependency
  provider                 = aws.secondary
  route_table_id           = aws_route_table.private_secondary[1].id
  destination_cidr_block   = aws_vpc.main.cidr_block
  transit_gateway_id       = aws_ec2_transit_gateway.main.id
}

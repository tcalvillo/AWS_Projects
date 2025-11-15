
resource "aws_route" "main_vpc_private_to_tgw" {
  route_table_id         = aws_route_table.private_main[0].id
  destination_cidr_block = aws_vpc.secondary.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

resource "aws_route" "main_vpc_private_to_tgw_2" {
  route_table_id         = aws_route_table.private_main[1].id
  destination_cidr_block = aws_vpc.secondary.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
}

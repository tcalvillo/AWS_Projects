
# Main VPC Public Subnet Associations
resource "aws_route_table_association" "public_main" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_main.id
}

# Main VPC Private Subnet Associations
resource "aws_route_table_association" "private_main" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_main[count.index].id
}

# Secondary VPC Public Subnet Associations
resource "aws_route_table_association" "public_secondary" {
  provider       = aws.secondary
  count          = 2
  subnet_id      = aws_subnet.public_secondary[count.index].id
  route_table_id = aws_route_table.public_secondary.id
}

# Secondary VPC Private Subnet Associations
resource "aws_route_table_association" "private_secondary" {
  provider       = aws.secondary
  count          = 2
  subnet_id      = aws_subnet.private_secondary[count.index].id
  route_table_id = aws_route_table.private_secondary[count.index].id
}

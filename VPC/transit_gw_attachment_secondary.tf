
resource "aws_ec2_transit_gateway_vpc_attachment" "secondary_vpc" {
  depends_on         = [aws_ec2_transit_gateway.main]  # Explicit dependency
  provider           = aws.secondary
  subnet_ids         = [aws_subnet.public_secondary[0].id, aws_subnet.public_secondary[1].id]
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.secondary.id

  tags = {
    Name = "Secondary-VPC-TGW-Attachment"
  }
}

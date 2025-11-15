
resource "aws_ec2_transit_gateway_vpc_attachment" "main_vpc" {
  subnet_ids         = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.main.id
  tags = {
    Name = "Main-VPC-TGW-Attachment"
  }
}

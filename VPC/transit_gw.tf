
resource "aws_ec2_transit_gateway" "main" {
  description = "Main Transit Gateway for cross-VPC connectivity"
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support = "enable"
  vpn_ecmp_support = "enable"
  tags = {
    Name = "Main-Transit-Gateway"
  }
}


resource "aws_vpc" "secondary" {
  provider             = aws.secondary
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Secondary-VPC"
  }
}

resource "aws_vpc_dhcp_options_association" "secondary_dns" {
  provider      = aws.secondary
  vpc_id        = aws_vpc.secondary.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver_secondary.id
}

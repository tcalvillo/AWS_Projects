
resource "aws_eip" "nat_elastic_ip_main" {
  count  = 2
  domain = "vpc"  # New argument
  tags = {
    Name = "EIP-for-NAT-GW-Main-${count.index + 1}"
  }
}

resource "aws_eip" "nat_elastic_ip_secondary" {
  provider = aws.secondary
  count    = 2
  domain   = "vpc"  # Updated
  tags = {
    Name = "EIP-for-NAT-GW-Secondary-${count.index + 1}"
  }
}


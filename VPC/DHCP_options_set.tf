# Primary DHCP Options Set (us-east-1)
resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["8.8.8.8", "8.8.4.4"]
  tags = {
    Name = "Main-DHCP-Options"
  }
}

# Secondary DHCP Options Set (us-west-1)
resource "aws_vpc_dhcp_options" "dns_resolver_secondary" {
  provider = aws.secondary
  domain_name_servers = ["8.8.8.8", "8.8.4.4"]
  tags = {
    Name = "Secondary-DHCP-Options"
  }
}

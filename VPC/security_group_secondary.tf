
resource "aws_security_group" "secondary_vpc_sg" {
  provider    = aws.secondary
  name        = "secondary-vpc-security-group"
  description = "Allow TLS, SSH, and HTTP inbound traffic from Secondary VPC, and all outbound traffic"
  vpc_id      = aws_vpc.secondary.id

  tags = {
    Name = "secondary-vpc-security-group"
  }
}

# Inbound rule for TLS (HTTPS)
resource "aws_vpc_security_group_ingress_rule" "secondary_allow_tls_ipv4" {
  depends_on = [aws_security_group.secondary_vpc_sg]  # Explicit dependency
  security_group_id = aws_security_group.secondary_vpc_sg.id
  cidr_ipv4         = aws_vpc.secondary.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Inbound rule for SSH
resource "aws_vpc_security_group_ingress_rule" "secondary_allow_ssh_ipv4" {
  depends_on = [aws_security_group.secondary_vpc_sg]  # Explicit dependency
  security_group_id = aws_security_group.secondary_vpc_sg.id
  cidr_ipv4         = aws_vpc.secondary.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Inbound rule for HTTP
resource "aws_vpc_security_group_ingress_rule" "secondary_allow_http_ipv4" {
  depends_on = [aws_security_group.secondary_vpc_sg]  # Explicit dependency
  security_group_id = aws_security_group.secondary_vpc_sg.id
  cidr_ipv4         = aws_vpc.secondary.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Outbound rule: Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "secondary_allow_all_outbound" {
  depends_on = [aws_security_group.secondary_vpc_sg]  # Explicit dependency
  security_group_id = aws_security_group.secondary_vpc_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"  # All protocols
}

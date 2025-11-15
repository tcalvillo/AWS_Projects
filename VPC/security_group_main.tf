
resource "aws_security_group" "vpc_security_group" {
  name        = "vpc-security-group"
  description = "Allow TLS, SSH, and HTTP inbound traffic from VPC, and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "vpc-security-group"
  }
}

# Inbound rule for TLS (HTTPS)
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.vpc_security_group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Inbound rule for SSH 
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.vpc_security_group.id
  cidr_ipv4         = aws_vpc.main.cidr_block  # NOTE: Restrict this further in production 
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Inbound rule for HTTP 
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.vpc_security_group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Outbound rule: Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.vpc_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"  # All protocols
}

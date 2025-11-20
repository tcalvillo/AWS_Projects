
# Security group for general VPC traffic (e.g., ALB, bastion host)
resource "aws_security_group" "vpc_security_group" {
  name        = "vpc-security-group"
  description = "Allow TLS, SSH, and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  # Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  # Allow SSH traffic (restricted to your public IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]  # Good! Restricted to your IP.
  }

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPC Security Group"
  }
}

# Security group for RDS (SQL Server)
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow inbound traffic to RDS"
  vpc_id      = aws_vpc.main.id

  # Allow SQL Server traffic from the VPC
  ingress {
    from_port   = 1433  # SQL Server default port
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Allow traffic from within the VPC
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}


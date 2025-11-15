resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main-IGW"
  }
}

resource "aws_internet_gateway" "igw_secondary" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary.id
  tags = {
    Name = "Secondary-IGW"
  }
}

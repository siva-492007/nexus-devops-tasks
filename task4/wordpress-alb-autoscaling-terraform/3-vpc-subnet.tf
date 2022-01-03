resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "subnet_1" {
  # vpc_id = aws_default_vpc.default_vpc.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "Default subnet for us-east-1a"
  }
}

resource "aws_default_subnet" "subnet_2" {
  # vpc_id = aws_default_vpc.default_vpc.id

  availability_zone = "us-east-1b"

  tags = {
    Name = "Default subnet for us-east-1b"
  }
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_az_1a" {
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Default subnet for ap-southeast-1a"
  }
}

resource "aws_default_subnet" "default_az_1b" {
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Default subnet for ap-southeast-1b"
  }
}

resource "aws_default_subnet" "default_az_1c" {
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "Default subnet for ap-southeast-1c"
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_default_vpc.default.default_network_acl_id
  subnet_ids = [
    aws_default_subnet.default_az_1a.id,
    aws_default_subnet.default_az_1b.id,
    aws_default_subnet.default_az_1c.id
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
resource "aws_vpc" "SG_test" {
  cidr_block = 192.168.0.0/16
  tags = {
    Name = "sg_test"
  }
}

resource "aws_subnet" "PORT_22_OPEN" {
  cidr_block = 192.168.0.10/24
  vpc_id = aws_vpc.SG_test.id
  tags = {
    Name = "subnet NACL(22) OPEN"
  }
}

resource "aws_subnet" "PORT_22_CLOSE" {
  cidr_block = 192.168.0.20/24
  vpc_id = aws_vpc.SG_test.id
  tags = {
    Name = "subnet NACL(22) CLOSE"
  }
}


resource "aws_network_acl" "PORT_22_OPEN" {
  vpc_id = aws_vpc.SG_test.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "main"
  }
}

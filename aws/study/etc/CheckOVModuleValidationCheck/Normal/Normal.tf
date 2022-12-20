resource "aws_vpc" "vpc_cand1" {
    cidr_block = "172.27.0.0/16"
    tags = {
        Name = "vpc_ingnoh"
    }
}

resource "aws_subnet" "subnet_cand1" {
    cidr_block = "172.27.10.0/24"
    vpc_id = aws_vpc.vpc_cand1.id
    tags = {
        Name = "subnet_cand1"
    }
}


resource "aws_security_group" "cand1_1" {
  name            = "Normal test"
  vpc_id          = aws_vpc.vpc_cand1.id
  description     = "Normal test"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    cidr_blocks     = ["1.1.1.1/32"]
  }
  tags = {
    Name = "module_test"
  }
}
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.my_vpc.id}"
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.my_subnet.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}


resource "aws_security_group" "test" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 60000
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 60000
    cidr_blocks = ["0.0.0.0/0"]

  }

}

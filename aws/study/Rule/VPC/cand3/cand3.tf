resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "test1" {
  vpc_id = aws_vpc.test1.id
}


#testcode
resource "aws_route_table" "pass1" {
  vpc_id = aws_vpc.test1.id
  route {
    cidr_block = "1.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
  route {
    cidr_block = "2.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
}

resource "aws_route_table" "pass2" {
  vpc_id = aws_vpc.test1.id
}
resource "aws_route" "pass2_1" {
  route_table_id = aws_route_table.pass2.id
  destination_cidr_block = "1.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
resource "aws_route" "pass2_2" {
  route_table_id = aws_route_table.pass2.id
  destination_cidr_block = "2.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}

resource "aws_route_table" "fail1_1" {
  vpc_id = aws_vpc.test1.id
  route {
    cidr_block = "1.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
}
resource "aws_route" "test1" {
  route_table_id = aws_route_table.fail1_1.id
  destination_cidr_block = "2.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
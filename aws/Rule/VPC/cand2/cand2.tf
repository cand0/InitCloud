resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "test1" {
  vpc_id = aws_vpc.test1.id
}

resource "aws_route_table" "test1" {
  vpc_id = aws_vpc.test1.id
}
resource "aws_route_table" "test2" {
  vpc_id = aws_vpc.test1.id
}


resource "aws_route_table_association" "pass" {
  route_table_id = "${aws_route_table.test1.id}"
  gateway_id = "${aws_internet_gateway.test1.id}"
}

resource "aws_route_table_association" "fail1_1" {
  route_table_id = "${aws_route_table.test1.id}"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
resource "aws_route_table_association" "fail1_2" {
  route_table_id = "${aws_route_table.test1.id}"
  gateway_id = "${aws_internet_gateway.test1.id}"
}

resource "aws_vpc" "cand1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "cand1" {
  vpc_id = aws_vpc.cand1.id
  cidr_block = cidrsubnet(aws_vpc.cand1.cidr_block, 8, 1)
}
resource "aws_route_table" "cand1" {
  vpc_id = aws_vpc.cand1.id
  tags = {
    Name = "cand1"
  }
}
resource "aws_route_table" "cand2" {
  vpc_id = aws_vpc.cand1.id
  tags = {
    Name = "cand2"
  }
}

#testcode

resource "aws_route_table_association" "pass" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}

resource "aws_route_table_association" "fail1_1" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}
resource "aws_route_table_association" "fail1_2" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}
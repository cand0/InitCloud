resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "test1" {
  vpc_id = aws_vpc.test1.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_network_acl" "test1" {
  vpc_id = aws_vpc.test1.id
  ingress {
    cidr_block = "0.0.0.0/0"
    action    = "deny"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 3
    to_port   = 0
  }
}

#testcode
resource "aws_network_acl_association" "pass" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}

resource "aws_network_acl_association" "fail1_1" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}
resource "aws_network_acl_association" "fail1_2" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}
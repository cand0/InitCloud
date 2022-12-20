resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}

#testcode
resource "aws_network_acl" "pass1" {
  vpc_id = aws_vpc.test1.id
  ingress {
    cidr_block = "0.0.0.0/0"
    action    = "deny"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 3
    to_port   = 0
  }
  ingress {
    action    = "allow"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 1
    to_port   = 0
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_network_acl" "pass2" {
  vpc_id = aws_vpc.test1.id
}
resource "aws_network_acl_rule" "pass2_1" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.pass2.id}"
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 1
  from_port = 0
  to_port = 0
}
resource "aws_network_acl_rule" "pass2_1" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.pass2.id}"
  protocol       = "tcp"
  rule_action    = "deny"
  rule_number    = 3
  from_port = 0
  to_port = 0
}



resource "aws_network_acl" "fail" {
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
resource "aws_network_acl_rule" "fail" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.fail.id}"
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 1
  from_port = 0
  to_port = 0
}



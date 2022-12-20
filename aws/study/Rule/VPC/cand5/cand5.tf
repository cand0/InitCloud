resource "aws_vpc" "cand1" {
  cidr_block = "10.0.0.0/16"
}

#testcode
resource "aws_security_group" "fail" {
  vpc_id      = aws_vpc.cand1.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "fail" {
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["1.0.0.0/8"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}

resource "aws_security_group" "pass1" {
  vpc_id      = aws_vpc.cand1.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "pass2" {
  vpc_id = aws_vpc.cand1.id
}
resource "aws_security_group_rule" "pass2" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}

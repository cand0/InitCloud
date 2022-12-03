resource "aws_vpc" "cand1" {
  cidr_block = "10.0.0.0/16"
}

#testcode
resource "aws_security_group" "fail" {
  vpc_id      = aws_vpc.cand1.id
  ingress {
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cand1.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "fail" {
  from_port         = 82
  to_port           = 82
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "ingress"
}

resource "aws_security_group" "pass1" {
  vpc_id      = aws_vpc.cand1.id
  ingress {
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cand1.cidr_block]
  }
  ingress {
    from_port = 82
    protocol  = "tcp"
    to_port   = 82
    cidr_blocks = ["0.0.0.0/0"]
  }
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
resource "aws_security_group_rule" "pass2-1" {
  from_port         = 81
  to_port           = 81
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "ingress"
}
resource "aws_security_group_rule" "pass2-2" {
  from_port         = 82
  to_port           = 82
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "ingress"
}
resource "aws_security_group_rule" "pass2-3" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}

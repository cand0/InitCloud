resource "aws_security_group" "sg_cand1_1" {
  name            = "sg_test_cand1_1"
  vpc_id          = module.network.vpc_id
  description     = "cand1_1&cand1_2 communication sg"
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "TCP"
    security_groups = [aws_security_group.sg_cand1_2.id]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_test_cand1_1"
  }
}


resource "aws_security_group" "sg_cand1_2" {
  name            = "sg_test_cand1_2"
  vpc_id          = module.network.vpc_id
  description     = "cand1_1&cand1_2 communication sg"
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_test_cand1_2"
  }
}

resource "aws_security_group_rule" "sg_rule_cand1" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.sg_cand1_2.id
  security_group_id = aws_security_group.sg_cand1_1.id
}

resource "aws_security_group_rule" "sg_rule_cand2" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.sg_cand1_1.id
  security_group_id = aws_security_group.sg_cand1_2.id
}
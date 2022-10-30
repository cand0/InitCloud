resource "aws_security_group" "cand1_1" {
  name            = "Variable test"
  vpc_id          = var.vpc_id
  description     = "Variable test"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    cidr_blocks     = [var.cidr_sg]
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
resource "aws_security_group" "cand1_1" {
  name            = "module test"
  vpc_id          = var.vpc_id
  description     = "module test"
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "TCP"
    cidr_blocks     = [var.cidr_sg]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "module_test"
  }
}
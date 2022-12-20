resource "aws_security_group" "cand1_1" {
  name            = "Static test"
  vpc_id          = var.vpc_id
  description     = "Static test"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"]
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
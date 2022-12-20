resource "aws_vpc" "vpc_cand1" {
    cidr_block = var.cidr_vpc
    tags = {
        Name = "vpc_ingnoh"
    }
}


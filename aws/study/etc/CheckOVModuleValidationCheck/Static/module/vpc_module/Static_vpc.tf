resource "aws_vpc" "vpc_cand1" {
    cidr_block = var.cidr_vpc
    tags = {
        Name = "vpc_ingnoh"
    }
}

resource "aws_subnet" "subnet_cand1" {
    cidr_block = var.subnet_cidr_cand1
    vpc_id = aws_vpc.vpc_cand1.id
    tags = {
        Name = "subnet_cand1"
    }
}


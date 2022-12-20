
data "aws_vpc" "cand1" {
  id = "vpc-0cf8795d662e0b719"
}

resource "aws_subnet" "cand1" {
  vpc_id = "${data.aws_vpc.cand1.id}"
  cidr_block = cidrsubnet(data.aws_vpc.cand1.cidr_block, 8, 1)
}
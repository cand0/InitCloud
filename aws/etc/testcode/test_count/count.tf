# count 갯수에 맞추어 subnet이 생성되어야 한다. <- visualization이 되는가?


resource "aws_vpc" "cand1" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "cand1" {
  count = 2
  vpc_id = "${aws_vpc.cand1.id}"
  cidr_block = cidrsubnet(aws_vpc.cand1.cidr_block, 8, count.index)
}

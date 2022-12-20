
resource "aws_subnet" "cand1" {
  vpc_id = "${module.vpc.vpc_id}"
  cidr_block = "${module.vpc.vpc_cidr}"
}
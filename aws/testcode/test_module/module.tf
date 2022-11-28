module "vpc" {
  source = "../vpc_module"
  cidr_vpc = "10.10.0.0/16"
}

resource "aws_subnet" "cand1" {
  vpc_id = "${module.vpc.vpc_id}"
  cidr_block = "${module.vpc.vpc_cidr}"
}
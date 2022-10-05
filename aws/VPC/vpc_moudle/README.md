※ module usages

module "network" {
    source = {path}/vpc_moudle
    cidr_vpc = {cidr_vpc}
    subnet_cidr_cand1 = {cidr_subnet}
    subnet_cidr_cand2 = {cidr_subnet}
    subnet_cidr_cand3 = {cidr_subnet}
}

resource "aws_instance" "web" {
  // skip
  subnet_id = module.network.private_subnet_cand1_id
  // skip
}
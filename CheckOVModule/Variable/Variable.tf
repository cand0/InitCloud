module "network" {
  source = "./module/vpc_module"
  cidr_vpc = "172.29.0.0/16"
  subnet_cidr_cand1 = "172.29.10.0/24"
}

module "sg" {
  vpc_id = module.network.vpc_id
  source = "./module/sg"
  cidr_sg = "0.0.0.0/0"
}

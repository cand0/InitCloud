module "network" {
  source = "./module/vpc_module"
  cidr_vpc = "172.28.0.0/16"
  subnet_cidr_cand1 = "172.28.10.0/24"

}

module "sg" {
  vpc_id = module.network.vpc_id
  source = "./module/sg"
}

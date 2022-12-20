module "network" {
    source = "../../../../module/vpc_module"
    cidr_vpc = "172.17.0.0/16"
    subnet_cidr_cand1 = "172.17.10.0/24"
    subnet_cidr_cand2 = "172.17.20.0/24"
    subnet_cidr_cand3 = "172.17.30.0/24"
}

resource "aws_instance" "cand2" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.network.private_subnet_cand1_id
  tags = {
    Name = "cand2"
  }
}

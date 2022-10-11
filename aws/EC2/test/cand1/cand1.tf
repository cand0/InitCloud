module "network" {
    source = "../../../../module/vpc_module"
    cidr_vpc = "172.16.0.0/16"
    subnet_cidr_cand1 = "172.16.10.0/24"
    subnet_cidr_cand2 = "172.16.20.0/24"
    subnet_cidr_cand3 = "172.16.30.0/24"
}

resource "aws_instance" "cand1_1" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.network.private_subnet_cand1_id
  tags = {
    Name = "cand1_1"
  }
  vpc_security_group_ids = [aws_security_group.sg_cand1_1.id]
}

resource "aws_instance" "cand1_2" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.network.private_subnet_cand2_id
  tags = {
    Name = "cand1_2"
  }
  vpc_security_group_ids = [aws_security_group.sg_cand1_2.id]

}

resource "aws_instance" "cand1_3" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.network.private_subnet_cand3_id
  tags = {
    Name = "cand1_3"
  }
}
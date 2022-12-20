module "vpc" {
  source = "../../custom-terraform-aws-vpc"

  name = "cand1"
  cidr = "10.1.0.0/18"

  azs             = ["us-east-1a"]
  private_subnets = ["10.1.0.0/22"]
  public_subnets  = ["10.1.4.0/22"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "checkOV_sg_test_module" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Name = "checkOV_sg_test_module"
  }
}
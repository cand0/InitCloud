module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git"

  name = "cand1"
  cidr = "10.1.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.1.10.0/24"]
  public_subnets  = ["10.1.20.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "github_module_test" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Name = "github_module_test"
  }
}
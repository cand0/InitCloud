module "vpc" {
  source = "../custom-terraform-aws-vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

### use module, checkOV security group test
resource "aws_instance" "checkOV_sg_test_module" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Name = "checkOV_sg_test_module"
  }
  vpc_security_group_ids = [module.vpc.checkOV_sg_test_module_id]
  monitoring = true
}

### not use module, checkOV security group test
resource "aws_vpc" "checkOV_sg_test_main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "checkOV_sg_test_main"
  }
}

resource "aws_subnet" "checkOV_sg_test_main" {
  cidr_block = "10.0.10.0/24"
  vpc_id = "${aws_vpc.checkOV_sg_test_main.id}"
  tags = {
    Name = "checkOV_sg_test_main"
  }
}

resource "aws_instance" "checkOV_sg_test_main" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.checkOV_sg_test_main.id
  tags = {
    Name = "checkOV_sg_test_main"
  }
  vpc_security_group_ids = [aws_security_group.checkOV_sg_test_main.id]
  monitoring = true
}

resource "aws_security_group" "checkOV_sg_test_main" {
  name              = "checkOV_sg_test_main"
  vpc_id            = aws_vpc.checkOV_sg_test_main.id
  description       = "checkOV_sg_test_main"
  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name            = "checkOV_sg_test_main"
  }
}
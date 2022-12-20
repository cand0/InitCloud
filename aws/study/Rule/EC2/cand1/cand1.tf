resource "aws_vpc" "test1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "test1" {
  vpc_id = aws_vpc.test1.id
  cidr_block = "10.0.0.0/24"
}
resource "aws_internet_gateway" "test1" {}
resource "aws_internet_gateway_attachment" "test1" {
  internet_gateway_id = "${aws_internet_gateway.test1.id}"
  vpc_id              = "${aws_vpc.test1.id}"
}
resource "aws_instance" "test1" {
  subnet_id = "${aws_subnet.test1.id}"
  ami               = "ami-0574da719dca65348"
  instance_type     = "t2.micro"
}
resource "aws_eip" "test1" {
  vpc = true
}


#testcode
resource "aws_eip_association" "pass" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}

resource "aws_eip_association" "fail1_1" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}
resource "aws_eip_association" "fail1_2" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}



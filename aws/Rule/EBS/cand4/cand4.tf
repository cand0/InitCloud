resource "aws_vpc" "cand1" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "cand1" {
  vpc_id = aws_vpc.cand1.id
  cidr_block = "10.0.0.0/24"
}



#testcode
resource "aws_ebs_volume" "fail" {
  availability_zone = "${aws_instance.fail.availability_zone}"
  size              = 1
}

#fail
resource "aws_volume_attachment" "fail" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.fail.id
  instance_id = aws_instance.fail.id
}
resource "aws_instance" "fail" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sdr"
    volume_size = 10
  }
}



resource "aws_ebs_volume" "pass" {
  availability_zone = "${aws_instance.pass1.availability_zone}"
  size              = 1
}

#pass
resource "aws_volume_attachment" "pass1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.pass.id
  instance_id = aws_instance.pass1.id
}
resource "aws_instance" "pass1" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
}


resource "aws_instance" "pass2" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sdr"
    volume_size = 10
  }
}
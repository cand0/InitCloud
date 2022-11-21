resource "aws_ebs_volume" "fail" {
  availability_zone = "us-east-1a"
  size              = 10
  tags = {
    Name = "cand1_volume"
    Name = "cand2_volume"
  }
}

resource "aws_ebs_volume" "pass" {
  availability_zone = "us-east-1a"
  size              = 10
  tags = {
    Name = "cand1_volume"
  }
}

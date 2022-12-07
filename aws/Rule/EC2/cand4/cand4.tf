resource "aws_ebs_volume" "test" {
  availability_zone = "us-east-1a"
  size = 10
}
resource "aws_ebs_snapshot" "test" {
  volume_id = "${aws_ebs_volume.test.id}"
}
resource "aws_ami" "example" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0" # Enforce usage of IMDSv2. You can safely remove this line if your application explicitly doesn't support it.
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = "${aws_ebs_snapshot.test.id}"
    volume_size = 10
  }
}


#testcode
resource "aws_ami_launch_permission" "pass" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
resource "aws_ami_launch_permission" "fail1_1" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
resource "aws_ami_launch_permission" "fail1_2" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
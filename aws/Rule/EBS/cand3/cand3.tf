
resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 40
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.example.id
}


#testcode

resource "aws_snapshot_create_volume_permission" "fail1_1" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}
resource "aws_snapshot_create_volume_permission" "fail1_2" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}
resource "aws_snapshot_create_volume_permission" "pass" {
  snapshot_id = aws_ebs_snapshot.example_snapshot.id
  account_id  = "12345678"
}

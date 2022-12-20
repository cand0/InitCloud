
#testcode
resource "aws_ebs_encryption_by_default" "fail1_1" {
  enabled = true
}

resource "aws_ebs_encryption_by_default" "fail1_2" {
  enabled = false
}

resource "aws_ebs_encryption_by_default" "pass" {
  enabled = true
}

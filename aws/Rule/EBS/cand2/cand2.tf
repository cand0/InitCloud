resource "aws_kms_key" "cand1" {
  description = "test1"
}


#testcode
resource "aws_ebs_default_kms_key" "fail1_1" {
  key_arn = "${aws_kms_key.cand1.arn}"
}
resource "aws_ebs_default_kms_key" "fail1_2" {
  key_arn = "${aws_kms_key.cand1.arn}"
}

resource "aws_ebs_default_kms_key" "pass" {
  key_arn = "${aws_kms_key.cand1.arn}"
}

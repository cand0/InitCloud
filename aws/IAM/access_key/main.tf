resource "aws_iam_user" "cand1" {
  name = "accessKey_test_cand1"
}

resource "aws_iam_access_key" "accesskey_cand1" {
  user = aws_iam_user.cand1.name
}

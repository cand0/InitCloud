resource "aws_iam_user" "cand1" {
  name = "accessKey_test_cand1"
}

resource "aws_iam_access_key" "accesskey_cand1" {
  user = aws_iam_user.cand1.name
}

resource "aws_iam_user" "cand2" {
  name = "user_cand2"
}

resource "aws_iam_user_login_profile" "profile_cand2" {
  user = aws_iam_user.cand2.name
}

output "password" {
  value = aws_iam_user_login_profile.profile_cand2.encrypted_password
}
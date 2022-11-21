resource "aws_iam_access_key" "lb1" {
  user    = aws_iam_user.lb.name
  pgp_key = filebase64("./iam.gpg.pubkey")
}

resource "aws_iam_access_key" "lb2" {
  user    = aws_iam_user.lb.name
  pgp_key = filebase64("./iam.gpg.pubkey")
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "secret1" {
  value = aws_iam_access_key.lb1.encrypted_secret
}
output "secret2" {
  value = aws_iam_access_key.lb2.encrypted_secret
}
resource "aws_iam_group" "iam_group_cand1" {
  name = "group_cand1"
}

resource "aws_iam_user" "iam_cand1" {
  name = "iam_cand1"
}
resource "aws_iam_group_membership" "cand1_group_matching" {
  name = aws_iam_group.iam_group_cand1.name
  users = [
    aws_iam_user.iam_cand1.name
  ]
  group = aws_iam_group.iam_group_cand1.name
}

resource "aws_iam_user_policy" "iam_user_policy_cand1" {
  name  = "cand1-admin"
  user  = aws_iam_user.iam_cand1.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
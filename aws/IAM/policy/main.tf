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

resource "aws_iam_group_policy" "iam_group_policy_cand1" {
  name = "group_policy_cand1"
  group = aws_iam_group.iam_group_cand1.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  }
  )
}

resource "aws_iam_policy" "policy_cand1" {
  name    = "policy_test_cand1"
  policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  }
  )
}

resource "aws_iam_group_policy_attachment" "attach_test_cand1" {
  group = aws_iam_group.iam_group_cand1.name
  policy_arn = aws_iam_policy.policy_cand1.arn
}


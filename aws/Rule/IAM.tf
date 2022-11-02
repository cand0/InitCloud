

resource "aws_iam_group" "test_cand0" {
  name = var.group_name
}


resource "aws_iam_user" "test_cand0" {
  name = var.user_name
}

resource "aws_iam_group_membership" "test_cand0" {
  group = aws_iam_group.test_cand0.id
  name  = "test_cand0"
  users = [aws_iam_user.test_cand0.id]
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
        Effect = "Deny"
        Resource = "*"
      }
    ]
  }
  )
}

resource "aws_iam_policy" "policy_cand2" {
  name    = "policy_test_cand2"
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
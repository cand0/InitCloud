resource "aws_iam_group" "cand1" {
  name = "cand1"
}


#fail
resource "aws_iam_group_policy" "fail1_1" {
  name  = "cand1"
  group = aws_iam_group.cand1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy" "fail1_2" {
  name  = "cand1"
  group = aws_iam_group.cand1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}


#pass
resource "aws_iam_group_policy" "pass" {
  name  = "cand1"
  group = aws_iam_group.cand1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "*",
        ]
        Effect   = "Deny"
        Resource = "*"
      }
    ]
  })
}
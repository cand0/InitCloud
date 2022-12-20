resource "aws_iam_role" "cand1" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#fail
resource "aws_iam_role_policy" "fail1_1" {
  name = "cand1"
  role   = "${aws_iam_role.cand1.id}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "fail1_2" {
  name = "cand1"
  role   = "${aws_iam_role.cand1.id}"

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

#pass
resource "aws_iam_role_policy" "pass" {
  name = "cand1"
  role   = "${aws_iam_role.cand1.id}"

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
          "ec2:Describe*",
        ]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}
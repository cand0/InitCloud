
resource "aws_iam_role" "role" {
  name               = "cand2-iam-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


# test case duplicate aws_iam_role_policy
resource "aws_iam_role_policy" "fail1_1" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "fail1_2" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Deny"
    }
  ]
}
EOF
}

# test case1
resource "aws_iam_role_policy" "pass" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

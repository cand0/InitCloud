resource "aws_iam_group" "iam_group_cand1" {
  name = "cand1_group"
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

resource "aws_iam_role" "cand1_role" {
  name               = "cand1-iam-role"
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

resource "aws_iam_role_policy" "cand1_s3" {
  name   = "cand1-s3-download"
  role   = aws_iam_role.cand1_role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject"
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

resource "aws_iam_instance_profile" "cand1" {
  name = "cand1-profile"
  role = aws_iam_role.cand1_role.name
}



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

/*
permission example
  managed_policy_arns > aws_iam_role_policy
*/

resource "aws_iam_role" "cand2_role" {
  name               = "cand2-iam-role"
  path               = "/"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
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
resource "aws_iam_role_policy" "cand2_s3" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.cand2_role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject*"
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


/*
permission example
  managed_policy_arns < aws_iam_role_policy
*/
resource "aws_iam_role" "cand3_role" {
  name               = "cand3-iam-role"
  path               = "/"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
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
resource "aws_iam_role_policy" "cand3_s3" {
  name   = "cand3-s3-FullPermission"
  role   = aws_iam_role.cand3_role.id
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


#aws_iam_role_policy attachment test

resource "aws_iam_role" "iam_cand4" {
  name = "cand4-iam-role"
  assume_role_policy = <<EOF
  {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "policy_cand4" {
  name = "policy_cand4"
  description = "cand4 policy test"

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

resource "aws_iam_role_policy_attachment" "cand4_role_policy_attachment" {
  role = aws_iam_role.iam_cand4.name
  policy_arn = aws_iam_policy.policy_cand4.arn
}

# membership test


resource "aws_iam_user_group_membership" "membership_cand1" {
  user = aws_iam_user.iam_cand1.name

  groups = [
    aws_iam_group.group_cand2.name,
    aws_iam_group.group_cand3.name
  ]
}
resource "aws_iam_user_group_membership" "membership_cand2" {
  user = aws_iam_user.iam_cand1.name
  groups = [
    aws_iam_group.group_cand4.name
  ]
}


resource "aws_iam_group" "group_cand2" {
  name = "group_cand2"
}
resource "aws_iam_group" "group_cand3" {
  name = "group_cand3"
}
resource "aws_iam_group" "group_cand4" {
  name = "group_cand4"
}
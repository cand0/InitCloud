![image](https://user-images.githubusercontent.com/53141739/200156014-e32e7f82-2c67-4938-97a9-b7af9c043389.png)


```
resource "aws_iam_role" "iam_cand4" {
  name = "cand4-iam-role"
  path = "/"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
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

resource "aws_iam_role_policy" "cand2_s3" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.iam_cand4.id
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

resource "aws_iam_role_policy" "cand3_s3" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.iam_cand4.id
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
```

Deny가 있는데 Allow한 룰 때문에 access 가 됨

선언 순서에 따라서 다르네

![image](https://user-images.githubusercontent.com/53141739/200156027-b3711825-b5e5-4f45-92c3-69bccc734b14.png)
```
resource "aws_iam_role" "iam_cand4" {
  name = "cand4-iam-role"
  path = "/"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
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

resource "aws_iam_role_policy" "cand2_s3" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.iam_cand4.id
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

resource "aws_iam_role_policy" "cand3_s3" {
  name   = "cand2-s3-GetObject"
  role   = aws_iam_role.iam_cand4.id
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
```

같은거 선언하면 위에선언한 애가 적용되네

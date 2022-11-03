resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-09d3b3274b6c5d4aa"
  subnet_id = "${aws_subnet.my_subnet.id}"
  security_groups = [aws_security_group.test.id]
  instance_type = "t2.micro"

  associate_public_ip_address = true

  iam_instance_profile = "${aws_iam_instance_profile.test_profile1.id}"

}
resource "aws_security_group" "test" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 60000
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 60000
    cidr_blocks = ["0.0.0.0/0"]

  }

}


resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.my_vpc.id}"
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.my_subnet.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}

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

resource "aws_iam_role" "iam_cand5" {
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
        "Effect": "Deny",
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

resource "aws_iam_instance_profile" "test_profile1" {
  name = "test_profile2"
  role = "${aws_iam_role.iam_cand4.name}"
}
resource "aws_iam_instance_profile" "test_profile2" {
  name = "test_profile2"
  role = "${aws_iam_role.iam_cand5.name}"
}
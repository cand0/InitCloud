### check

---

#### resource
aws_security_group.ingress <br />
aws_security_group_rule.type = ingress

#### level
medium

### explanation

---

aws_security_group.ingress와 aws_security_group_rule에서 type에 ingress가 함께 사용하면 안된다. <br />
왜냐하면 두개를 함께 적용하면 덮어 씨워지거나 충돌이 난다.

### insecure example

---

```go
resource "aws_route_table" "fail1_1" {
  vpc_id = aws_vpc.test1.id
  route {
    cidr_block = "1.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
}
resource "aws_route" "test1" {
  route_table_id = aws_route_table.fail1_1.id
  destination_cidr_block = "2.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
```


### secure example

---

```go
resource "aws_security_group" "pass1" {
  vpc_id      = aws_vpc.cand1.id
  ingress {
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.cand1.cidr_block]
  }
  ingress {
    from_port = 82
    protocol  = "tcp"
    to_port   = 82
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
```
or

```go
resource "aws_security_group" "pass2" {
  vpc_id = aws_vpc.cand1.id
}
resource "aws_security_group_rule" "pass2-1" {
  from_port         = 81
  to_port           = 81
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "ingress"
}
resource "aws_security_group_rule" "pass2-2" {
  from_port         = 82
  to_port           = 82
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "ingress"
}
resource "aws_security_group_rule" "pass2-3" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}
```

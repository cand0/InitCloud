### check

---

#### resource
aws_security_group.egress <br />
aws_security_group_rule.type = egress

#### level
medium

### explanation

---

aws_security_group.egress와 aws_security_group_rule에서 type에 egress가 함께 사용하면 안된다. <br />
왜냐하면 두개를 함께 적용하면 덮어 씨워지거나 충돌이 난다.

### insecure example

---

```go
resource "aws_security_group" "fail" {
  vpc_id      = aws_vpc.cand1.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "fail" {
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["1.0.0.0/8"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}
```


### secure example

---

```go
resource "aws_security_group" "pass1" {
  vpc_id      = aws_vpc.cand1.id
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
resource "aws_security_group_rule" "pass2" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.fail.id}"
  type              = "egress"
}
```

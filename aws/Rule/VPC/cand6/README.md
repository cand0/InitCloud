### check
---
egress의 default setting은 false이니 이 부분 신경 써서 룰 작성 <br />

#### resource
aws_network_acl.ingress <br />
aws_network_acl_rule.egress = false # default setting is egress = false 


#### level
medium

### explanation

---

aws_network_acl.ingress와 aws_network_acl_rule에서 egress에 false가 함께 사용하면 안된다. <br />
왜냐하면 두개를 함께 적용하면 덮어 씨워지거나 충돌이 난다.

### insecure example

---

```go
resource "aws_network_acl" "fail" {
  vpc_id = aws_vpc.test1.id
  ingress {
    cidr_block = "0.0.0.0/0"
    action    = "deny"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 3
    to_port   = 0
  }
}
resource "aws_network_acl_rule" "fail" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.fail.id}"
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 1
  from_port = 0
  to_port = 0
}

```


### secure example

---

```go
resource "aws_network_acl" "pass1" {
  vpc_id = aws_vpc.test1.id
  ingress {
    cidr_block = "0.0.0.0/0"
    action    = "deny"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 3
    to_port   = 0
  }
  ingress {
    action    = "allow"
    from_port = 0
    protocol  = "tcp"
    rule_no   = 1
    to_port   = 0
    cidr_block = "0.0.0.0/0"
  }
}
```
or

```go
resource "aws_network_acl" "pass2" {
  vpc_id = aws_vpc.test1.id
}
resource "aws_network_acl_rule" "pass2_1" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.pass2.id}"
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 1
  from_port = 0
  to_port = 0
}
resource "aws_network_acl_rule" "pass2_1" {
  egress = false      # default : false
  cidr_block = "0.0.0.0/0"
  network_acl_id = "${aws_network_acl.pass2.id}"
  protocol       = "tcp"
  rule_action    = "deny"
  rule_number    = 3
  from_port = 0
  to_port = 0
}
```

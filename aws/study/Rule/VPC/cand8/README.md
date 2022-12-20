### check

---

#### resource
aws_network_acl_association
  - network_acl_id
  - subnet_id

#### level
medium

### explanation

---

aws_network_acl_association 같은 network_acl_id와 subnet_id를 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 network_acl_id와 subnet_id를 적용하면 한개의 리소스는 적용되지 않기 때문이다.


### insecure example

---

```go
resource "aws_network_acl_association" "fail1_1" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}
resource "aws_network_acl_association" "fail1_2" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}
```


### secure example

---

```go
resource "aws_network_acl_association" "pass" {
  network_acl_id = "${aws_network_acl.test1.id}"
  subnet_id      = "${aws_subnet.test1.id}"
}

```

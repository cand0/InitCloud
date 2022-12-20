### check

---

#### resource
aws_route_table_association
  - route_table_id
  - subnet_id

#### level
medium

### explanation

---

aws_route_table_association 같은 route_table_id와 subnet_id를 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 route_table_id와 subnet_id를 적용하면 한개의 리소스는 적용되지 않기 때문이다.

aws_route_table_association 동일한 route_table_id와 subnet_id를 선언하면 안된다.


### insecure example

---

```go
resource "aws_route_table_association" "fail1_1" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}
resource "aws_route_table_association" "fail1_2" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}
```


### secure example

---

```go
resource "aws_route_table_association" "pass" {
  route_table_id = "${aws_route_table.cand1.id}"
  subnet_id = "${aws_subnet.cand1.id}"
}

```

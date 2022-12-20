### check

---

#### resource
aws_route_table.route
aws_route

#### level
low

### explanation

---

aws_route에서 route와 aws_route_table를 함꼐 사용하면 안된다. <br />
왜냐하면 두개의 resource에서 route와 aws_route_table를 적용하면 덮어씌워지거나 충돌이 난다.

aws_route에서 route와 aws_route_table를 함께 선언하면 안된다.


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
resource "aws_route_table" "pass1" {
  vpc_id = aws_vpc.test1.id
  route {
    cidr_block = "1.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
  route {
    cidr_block = "2.0.0.0/8"
    gateway_id = "${aws_internet_gateway.test1.id}"
  }
}
```
or

```go
resource "aws_route_table" "pass2" {
  vpc_id = aws_vpc.test1.id
}
resource "aws_route" "pass2_1" {
  route_table_id = aws_route_table.pass2.id
  destination_cidr_block = "1.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
resource "aws_route" "pass2_2" {
  route_table_id = aws_route_table.pass2.id
  destination_cidr_block = "2.0.0.0/8"
  gateway_id = "${aws_internet_gateway.test1.id}"
}
```

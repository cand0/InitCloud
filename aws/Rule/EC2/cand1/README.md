### check

---

#### resource
aws_eip_association
  - instance_id
  - allocation_id

#### level
low

### explanation

---

aws_eip_association에서 같은 instance_id와 allocation_id를 중복하여 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 instance_id와 allocation_id를 적용하면 한개의 리소스는 적용되지 않기 때문이다.


### insecure example

---

```go
resource "aws_eip_association" "fail1_1" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}
resource "aws_eip_association" "fail1_2" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}
```


### secure example

---

```go
resource "aws_eip_association" "pass" {
  instance_id   = aws_instance.test1.id
  allocation_id = aws_eip.test1.id
}
```

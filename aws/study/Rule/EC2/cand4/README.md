### check

---

#### resource
aws_ami_launch_permission
  - image_id
  - account_id

#### level
low

### explanation

---
aws_ami_launch_permission 에서 같은 image_id와 account_id를 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 정책을 적용한 후 한개의 리소스에서 값을 변경하면  코드와 인프라의 상태가 일치하지 않기 때문이다.

### insecure example

---

```go
resource "aws_ami_launch_permission" "fail1_1" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
resource "aws_ami_launch_permission" "fail1_2" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
```


### secure example

---

```go
resource "aws_ami_launch_permission" "pass" {
  image_id   = "${aws_ami.example.id}"
  account_id = "12345678"
}
```

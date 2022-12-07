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

aws_ami_launch_permission의 iamge_id와 account_id를 중복하여 선언하면 안된다. <br />
왜냐하면 두개의 aws_ami_launch_permission에서 같은 iamge_id와 account_id를적용하면 한개의 리소스는 적용되지 않기 때문이다.


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

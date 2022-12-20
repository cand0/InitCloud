### check

---

#### resource
aws_ec2_serial_console_access

#### level
low

### explanation

---

aws_ec2_serial_console_access을 중복하여 선언하면 안된다. <br />
왜냐하면 aws_ec2_serial_console_access resource는 설정을 적용하는 resource로 두번 적용하면 한개의 리소스는 적용되지 않기 때문이다.


### insecure example

---

```go
resource "aws_ec2_serial_console_access" "fail1_1" {
  enabled = true
}
resource "aws_ec2_serial_console_access" "fail1_2" {
  enabled = false
}
```


### secure example

---

```go
resource "aws_ec2_serial_console_access" "pass" {
  enabled = true
}
```

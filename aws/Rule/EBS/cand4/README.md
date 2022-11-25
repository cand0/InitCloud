### check

---

#### resource
aws_volume_attachment
aws_instance.ebs_block_device

#### level
medium

### explanation

---
Terraform Note : If you use ebs_block_device on an aws_instance, Terraform will assume management over the full set of non-root EBS block devices for the instance, and treats additional block devices as drift. <br />

따라서 aws_ebs_volume_attachment 와 aws_instance에 ebs_block_device를 함께 사용하면 안된다.


### insecure example

---

```go
resource "aws_volume_attachment" "fail" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.fail.id
  instance_id = aws_instance.fail.id
}
resource "aws_instance" "fail" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sdr"
    volume_size = 10
  }
}
```


### secure example

---

```go
resource "aws_volume_attachment" "pass1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.pass.id
  instance_id = aws_instance.pass1.id
}
resource "aws_instance" "pass1" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
}

```
or

```go
resource "aws_instance" "pass2" {
  subnet_id = "${aws_subnet.cand1.id}"
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sdr"
    volume_size = 10
  }
}

```

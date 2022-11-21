### check

---

#### resource
aws_ebs_default_kms_key


### explanation

---

aws_ebs_default_kms_key는 ebs암호화를 할 때 default 키를 설정하는 리소스로 같은 계정에서 중복하여 설정하면 하나의 정책만 적용된다. <br />

따라서 같은 계정/리전 에서는 aws_ebs_default_kms_key 리소스를 한번만 선언하여야 한다.

### insecure example

---

```go
resource "aws_ebs_default_kms_key" "fail1_1" {
  key_arn = "${aws_kms_key.cand1.arn}"
}
resource "aws_ebs_default_kms_key" "fail1_2" {
  key_arn = "${aws_kms_key.cand1.arn}"
}
```


### secure example

---

```go
resource "aws_ebs_default_kms_key" "pass" {
  key_arn = "${aws_kms_key.cand1.arn}"
}

```


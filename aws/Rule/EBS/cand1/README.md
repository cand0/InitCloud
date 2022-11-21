### check

---

#### resource
aws_ebs_encryption_by_default


### explanation

---

aws_ebs_encryption_by_default는 ebs암호화 여부를 default로 설정하는 리소스로 같은 계정에서 중복하여 설정하면 하나의 정책만 적용된다. <br />

따라서 같은 계정/리전 에서는 aws_ebs_encryption_by_default 리소스를 한번만 선언하여야 한다.

### insecure example

---

```python
resource "aws_ebs_encryption_by_default" "fail1_1" {
  enabled = true
}

resource "aws_ebs_encryption_by_default" "fail1_2" {
  enabled = false
}
```

### secure example

---

```python
resource "aws_ebs_encryption_by_default" "pass" {
  enabled = true
}
```

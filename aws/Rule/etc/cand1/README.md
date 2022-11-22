### check

---

#### argument
tags


### explanation

---

tags 에서 같은 arguemt를 중복하여 선언하면 선언 순서에 따라 뒤에 선언한 구문이 적용이 된다. <br />

따라서 같은 리소스에서 tags 내에 argument에는 중복되어 내용을 선언하지 않는다.

### insecure example

---

```python
resource "aws_ebs_volume" "fail" {
  availability_zone = "us-east-1a"
  size              = 10
  tags = {
    Name = "cand1_volume"
    Name = "cand2_volume"
  }
}

```

### secure example

---

```python

resource "aws_ebs_volume" "pass" {
  availability_zone = "us-east-1a"
  size              = 10
  tags = {
    Name = "cand1_volume"
  }
}

```

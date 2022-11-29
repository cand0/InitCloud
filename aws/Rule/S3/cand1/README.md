### check

---

#### resource
aws_s3_bucket

#### level
HIGH

### explanation

---

aws_s3_bucket은 유일한 이름만 적용이 가능하다. 하지만 두개의 bucket name을 같게 한 후 동시에 apply를 하면 한개의 bucket이 생성된다. 해당 리소스 중 하나를 변경하면 코드와는 다른 상태가 infra에 적용된다.

aws_s3_bucket의 bucket name을 중복하여 선언하지 않는다.


### insecure example

---

```go
resource "aws_s3_bucket" "pass" {
  bucket = "test"
}

resource "aws_s3_bucket" "fail1_1" {
  bucket = "test"
}
```


### secure example

---

```go
resource "aws_s3_bucket" "fail1_2" {
  bucket = "test"
}

```

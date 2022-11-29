### check

---

#### resource
aws_s3_bucket_acl

#### level
high

### explanation

---

aws_s3_bucket_acl에서 같은 bucket을 대상으로 두개 이상의 선언이 중복되어 사용자가 의도하지 않는 결과가 발생한다.

aws_s3_bucket_acl에서 동일한 bucket을 설정하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_acl" "fail1_1" {
  bucket = aws_s3_bucket.test.id
  acl    = "private"
}
resource "aws_s3_bucket_acl" "fail1_2" {
  bucket = aws_s3_bucket.test.id
  acl    = "public"
}
```


### secure example

---

```go
resource "aws_s3_bucket_acl" "pass" {
  bucket = aws_s3_bucket.test.id
  acl    = "private"
}

```

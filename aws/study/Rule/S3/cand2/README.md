### check

---

#### resource
aws_s3_bucket_accelerate_configuration

#### level
low

### explanation

---

aws_s3_bucket_accelerate_configuration에서 같은 bucket을 대상으로 두개 이상을 선언할 시 선언이 중복되어 사용자가 의도하지 않을 결과가 발생한다.

aws_s3_bucket_accelerate_configuration에서 동일한 bucket을 설정하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_accelerate_configuration" "fail1_1" {
  bucket = aws_s3_bucket.test.bucket
  status = "Enabled"
}
resource "aws_s3_bucket_accelerate_configuration" "fail1_2" {
  bucket = aws_s3_bucket.test.bucket
  status = "Suspended"
}
```


### secure example

---

```go
resource "aws_s3_bucket_accelerate_configuration" "pass" {
  bucket = aws_s3_bucket.test.bucket
  status = "Enabled"
}

```

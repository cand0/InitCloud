### check

---

#### resource
aws_s3_bucket_analytics_configuration.name

#### level
low

### explanation

---

aws_s3_bucket_analytics_configuration은 유일한 name만 적용이 가능하다. 하지만 두개의 name을 같게 한 후 apply를 하면 하나의 정책이 선언된다. <br />
해당 리소스 중 하나를 변경하면 코드와는 다른 상태가 infra에 적용된다.

aws_s3_bucket_acl에서 동일한 name을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_analytics_configuration" "fail1_1" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}

resource "aws_s3_bucket_analytics_configuration" "fail1_2" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}

```


### secure example

---

```go
resource "aws_s3_bucket_analytics_configuration" "pass" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}
```

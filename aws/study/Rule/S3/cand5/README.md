### check

---

#### resource
aws_s3_bucket_cors_configuration.bucket

#### level
high

### explanation

---

aws_s3_bucket_cors_configuration에서 같은 bucket을 대상으로 cors 정책을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 bucket에 정책을 적용하면 한개의 정책은 적용되지 않기 때문이다.

aws_s3_bucket_cors_configuration에서 동일한 bucket을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_cors_configuration" "fail1_1" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_cors_configuration" "fail1_2" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }
}
```


### secure example

---

```go
resource "aws_s3_bucket_cors_configuration" "pass" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }
}

```

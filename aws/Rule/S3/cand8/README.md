### check

---

#### resource
aws_s3_bucket_lifecycle_configuration.bucket

#### level
medium

### explanation

---

aws_s3_bucket_lifecycle_configuration 같은 bucket을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 bucket을 적용하면 한개의 리소스는 적용되지 않기 때문이다.

aws_s3_bucket_lifecycle_configuration 동일한 bucket을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_lifecycle_configuration" "fail1_1" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "test1"
    status = "Enabled"
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "fail1_2" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "test2"
    status = "Enabled"
    noncurrent_version_transition {
      noncurrent_days = 34
      storage_class   = "GLACIER"
    }
  }
}
```


### secure example

---

```go
resource "aws_s3_bucket_lifecycle_configuration" "pass" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "test1"
    status = "Enabled"
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }
  }
}
```

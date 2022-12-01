### check

---

#### resource
aws_s3_bucket_intelligent_tiering_configuration.name

#### level
medium

### explanation

---

aws_s3_bucket_intelligent_tiering_configuration에서 같은 name을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 name의 정책을 적용하면 한개의 정책은 적용되지 않기 때문이다.

aws_s3_bucket_intelligent_tiering_configuration에서 동일한 name을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_intelligent_tiering_configuration" "fail1_1" {
  bucket = aws_s3_bucket.test.bucket
  name   = "test"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "fail1_2" {
  bucket = aws_s3_bucket.test.bucket
  name   = "test"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 181
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 121
  }
}
```


### secure example

---

```go
resource "aws_s3_bucket_intelligent_tiering_configuration" "pass" {
  bucket = aws_s3_bucket.test.bucket
  name   = "test"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 120
  }
}
```

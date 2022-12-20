### check

---

#### resource
aws_s3_bucket_server_side_encryption_configuration.bucket

#### level
medium

### explanation

---

aws_s3_bucket_server_side_encryption_configuration 같은 bucket을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 bucket을 적용하면 한개의 리소스는 적용되지 않기 때문이다.

aws_s3_bucket_server_side_encryption_configuration 동일한 bucket을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_server_side_encryption_configuration" "fail1_1" {
  bucket = aws_s3_bucket.test.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey1.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "fail1_2" {
  bucket = aws_s3_bucket.test.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey2.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
```


### secure example

---

```go
resource "aws_s3_bucket_server_side_encryption_configuration" "pass" {
  bucket = aws_s3_bucket.test.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey1.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
```

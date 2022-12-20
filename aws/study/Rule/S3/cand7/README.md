### check

---

#### resource
aws_s3_bucket_inventory.name

#### level
low

### explanation

---

aws_s3_bucket_inventory 같은 name을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 name의 정책을 적용하면 한개의 정책은 적용되지 않기 때문이다.

aws_s3_bucket_inventory 동일한 name을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_inventory" "fail1_1" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}

resource "aws_s3_bucket_inventory" "fail1_2" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Weekly"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}
```


### secure example

---

```go
resource "aws_s3_bucket_inventory" "pass" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}
```

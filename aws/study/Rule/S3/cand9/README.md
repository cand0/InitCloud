### check

---

#### resource
aws_s3_bucket_public_access_block.bucket

#### level
high

### explanation

---

aws_s3_bucket_public_access_block에서 같은 bucket을 선언하면 안된다. <br />
왜냐하면 두개의 resource에서 같은 bucket을 적용하면 한개의 리소스는 적용되지 않기 때문이다.

aws_s3_bucket_public_access_block 동일한 bucket을 선언하면 안된다.


### insecure example

---

```go
resource "aws_s3_bucket_public_access_block" "fail1_1" {
  bucket = aws_s3_bucket.example.id
}
resource "aws_s3_bucket_public_access_block" "fail1_2" {
  bucket = aws_s3_bucket.example.id
}
```


### secure example

---

```go
resource "aws_s3_bucket_public_access_block" "pass" {
  bucket = aws_s3_bucket.example.id
}
```

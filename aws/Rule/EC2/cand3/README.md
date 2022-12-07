### check

---

#### resource
aws_spot_datafeed_subscription

#### level
low

### explanation

---

aws_spot_datafeed_subscription를 중복하여 선언하면 안된다. <br />
왜냐하면 aws_spot_datafeed_subscription resource는 설정을 적용하는 resource로 두번 적용하면 한개의 리소스는 적용되지 않기 때문이다.


### insecure example

---

```go
resource "aws_spot_datafeed_subscription" "fail1_1" {
  bucket = aws_s3_bucket.cand1.bucket
}
resource "aws_spot_datafeed_subscription" "fail1_2" {
  bucket = aws_s3_bucket.cand1.bucket
}
```


### secure example

---

```go
resource "aws_spot_datafeed_subscription" "pass" {
  bucket = aws_s3_bucket.cand1.bucket
}
```

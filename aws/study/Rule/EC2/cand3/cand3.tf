resource "aws_s3_bucket" "cand1" {
  bucket = "cand1"
}


resource "aws_spot_datafeed_subscription" "pass" {
  bucket = aws_s3_bucket.cand1.bucket
}

resource "aws_spot_datafeed_subscription" "fail1_1" {
  bucket = aws_s3_bucket.cand1.bucket
}
resource "aws_spot_datafeed_subscription" "fail1_2" {
  bucket = aws_s3_bucket.cand1.bucket
}
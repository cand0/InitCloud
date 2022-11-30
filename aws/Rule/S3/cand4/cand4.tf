resource "aws_s3_bucket" "example" {
  bucket = "test"
}

#testcode

resource "aws_s3_bucket_analytics_configuration" "pass" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}

resource "aws_s3_bucket_analytics_configuration" "fail1_1" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}

resource "aws_s3_bucket_analytics_configuration" "fail1_2" {
  bucket = aws_s3_bucket.example.bucket
  name   = "EntireBucket"
}

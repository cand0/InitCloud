resource "aws_s3_bucket" "test1" {
  bucket = "test1-cand1"
}

resource "aws_s3_bucket_accelerate_configuration" "pass" {
  bucket = aws_s3_bucket.test1.bucket
  status = "Enabled"
}
resource "aws_s3_bucket_accelerate_configuration" "fail1_1" {
  bucket = aws_s3_bucket.test1.bucket
  status = "Enabled"
}
resource "aws_s3_bucket_accelerate_configuration" "fail1_2" {
  bucket = aws_s3_bucket.test1.bucket
  status = "Suspended"
}
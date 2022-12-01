resource "aws_s3_bucket" "bucket" {
  bucket = "cand1"
}

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
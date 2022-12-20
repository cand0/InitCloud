resource "aws_s3_bucket" "test" {
  bucket = "test"
}

#testcode

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
resource "aws_kms_key" "mykey1" {
  description             = "test1"
  deletion_window_in_days = 10
}
resource "aws_kms_key" "mykey2" {
  description             = "test2"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "test" {
  bucket = "test"
}


#testcode
resource "aws_s3_bucket_server_side_encryption_configuration" "pass" {
  bucket = aws_s3_bucket.test.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey1.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

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

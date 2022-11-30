resource "aws_s3_bucket" "example" {
  bucket = "test1"
}

resource "aws_s3_bucket_cors_configuration" "fail1_1" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_cors_configuration" "fail1_2" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_cors_configuration" "pass" {
  bucket = aws_s3_bucket.example.id

  cors_rule {
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
  }
}

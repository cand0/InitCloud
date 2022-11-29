resource "aws_s3_bucket" "pass" {
  bucket = "test"
}

resource "aws_s3_bucket" "fail1_1" {
  bucket = "test"
}

resource "aws_s3_bucket" "fail1_2" {
  bucket = "test"
}

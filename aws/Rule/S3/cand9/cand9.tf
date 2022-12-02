resource "aws_s3_bucket" "example" {
  bucket = "test"
}

#testcode
resource "aws_s3_bucket_public_access_block" "pass" {
  bucket = aws_s3_bucket.example.id
}

resource "aws_s3_bucket_public_access_block" "fail1_1" {
  bucket = aws_s3_bucket.example.id
}
resource "aws_s3_bucket_public_access_block" "fail1_2" {
  bucket = aws_s3_bucket.example.id
}
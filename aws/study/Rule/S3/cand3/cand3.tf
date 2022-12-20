resource "aws_s3_bucket" "test" {
  bucket = "test"
}



resource "aws_s3_bucket_acl" "pass" {
  bucket = aws_s3_bucket.test.id
  acl    = "private"
}


resource "aws_s3_bucket_acl" "fail1_1" {
  bucket = aws_s3_bucket.test.id
  acl    = "private"
}
resource "aws_s3_bucket_acl" "fail1_2" {
  bucket = aws_s3_bucket.test.id
  acl    = "public"
}


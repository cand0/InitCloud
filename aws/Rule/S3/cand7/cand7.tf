resource "aws_s3_bucket" "test1" {
  bucket = "test1"
}

resource "aws_s3_bucket" "test2" {
  bucket = "test2"
}



#testcode
resource "aws_s3_bucket_inventory" "pass" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}


resource "aws_s3_bucket_inventory" "fail1_1" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Daily"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}

resource "aws_s3_bucket_inventory" "fail1_1" {
  bucket = aws_s3_bucket.test1.id
  name   = "EntireBucketDaily"

  included_object_versions = "All"

  schedule {
    frequency = "Weekly"
  }

  destination {
    bucket {
      format     = "ORC"
      bucket_arn = aws_s3_bucket.test2.arn
    }
  }
}

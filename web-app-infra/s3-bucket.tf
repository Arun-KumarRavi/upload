# creating a S3 bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}


# enabling versioning for the S3 bucket

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#enabling server-side encryption for the S3 bucket

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


#block public access for the S3 bucket

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

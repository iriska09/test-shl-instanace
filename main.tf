provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-03d49b144f3ee2dc4"
  instance_type = "t2.micro"

  tags = {
    Name        = "example-instance"
    Environment = "production"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"

  tags = {
    Name        = "example-bucket"
    Environment = "production"
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

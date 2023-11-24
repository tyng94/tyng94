data "aws_s3_bucket" "terraform" {
  bucket = "tyio-terraform"
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket = data.aws_s3_bucket.terraform.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = data.aws_s3_bucket.terraform.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyUnEncryptedObjectUploads"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${data.aws_s3_bucket.terraform.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" : "aws:kms"
          }
        }
      },
      {
        Sid       = "DenyInsecureConnections"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${data.aws_s3_bucket.terraform.arn}",
          "${data.aws_s3_bucket.terraform.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" : false
          }
        }
      }
    ]
  })
}
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

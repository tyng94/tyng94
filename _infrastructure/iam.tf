resource "aws_iam_user" "continuous_integration" {
  name = "CI"
}

resource "aws_iam_access_key" "continuous_integration" {
  user = aws_iam_user.continuous_integration.name
}

resource "aws_iam_role" "terraformer" {
  name = "terraformer"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.continuous_integration.arn
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "terraformer_policy" {
  name = "terraformer"
  role = aws_iam_role.terraformer.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "iam:*",
          "kms:*",
          "logs:*",
          "rds:*",
          "s3:*",
        ]
        Effect = "Allow",
        "Resource" : "*"
      }
    ]
  })
}
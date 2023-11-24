resource "aws_iam_user" "continuous_integration" {
  name = "CI"
}

resource "aws_iam_access_key" "continuous_integration" {
  user = aws_iam_user.continuous_integration.name
}

resource "aws_iam_policy" "terraform_base_policy" {
  name        = "terraform-base-policy"
  description = "Policy for terraformer to perform base operations"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:*",
          "rds:*",
          "s3:*",
        ]
        Effect = "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "continuous_integration_policies" {
  user       = aws_iam_user.continuous_integration.name
  policy_arn = aws_iam_policy.terraform_base_policy.arn
}
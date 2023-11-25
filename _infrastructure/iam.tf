resource "aws_iam_openid_connect_provider" "default" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com.",
  ]

  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
}

resource "aws_iam_role" "terraformer" {
  name = "terraformer"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.default.arn
        }
        Condition = {
          StringEquals = {
            "${aws_iam_openid_connect_provider.default.url}:sub" = "repo:tyng94/tyng94",
            "${aws_iam_openid_connect_provider.default.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraformer" {
  role       = aws_iam_role.terraformer.name
  policy_arn = aws_iam_policy.terraform_base_policy.arn
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
          "ec2:*",
          "rds:*",
          "s3:*",
        ]
        Effect = "Allow",
        "Resource" : "*"
      }
    ]
  })
}
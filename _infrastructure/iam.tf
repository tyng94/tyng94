resource "aws_iam_user" "continuous_integration" {
  name = "CI"
}

resource "aws_iam_access_key" "continuous_integration" {
  user = aws_iam_user.continuous_integration.name
}
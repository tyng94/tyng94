resource "aws_db_subnet_group" "default" {
  name        = "main"
  description = "Default DB subnet group"
  subnet_ids = [
    aws_default_subnet.default_az_1a.id,
    aws_default_subnet.default_az_1b.id,
    aws_default_subnet.default_az_1c.id
  ]
}
output "default_vpc_security_group_id" {
  description = "Default VPC Security Group ID"
  value       = aws_default_security_group.default.id
}
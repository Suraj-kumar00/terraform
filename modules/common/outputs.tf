output "ec2_role_name" {
  description = "Name of the IAM role created for EC2"
  value       = aws_iam_role.ec2_common_role.name
}

output "ec2_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_arn" {
  description = "ARN of the IAM role created for EC2"
  value       = aws_iam_role.ec2_common_role.arn
}
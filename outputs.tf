output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_user_id" {
  description = "AWS User ID"
  value       = data.aws_caller_identity.current.user_id
}

output "aws_region" {
  description = "AWS Region"
  value       = data.aws_region.current.name
}

output "availability_zones" {
  description = "List of available availability zones"
  value       = data.aws_availability_zones.available.names
}

output "amazon_linux_ami_id" {
  description = "Latest Amazon Linux 2 AMI ID"
  value       = data.aws_ami.amazon_linux.id
}

output "amazon_linux_ami_name" {
  description = "Latest Amazon Linux 2 AMI name"
  value       = data.aws_ami.amazon_linux.name
}
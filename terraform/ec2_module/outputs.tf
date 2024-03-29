output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.rails_instance.id
}
output "app_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.rails_instance.public_ip
}
output "db_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.db_instance.public_ip
}
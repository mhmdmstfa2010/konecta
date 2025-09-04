# 1️⃣ Output Public IP of the EC2 Instance
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

# 2️⃣ Output Instance ID
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}

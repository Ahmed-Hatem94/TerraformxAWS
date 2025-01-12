output "public_ip" {
  description = "The public IP addresses of the instances"
  value       = aws_instance.instance[*].public_ip
}

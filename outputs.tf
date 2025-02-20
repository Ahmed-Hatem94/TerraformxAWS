output "your_public_ip" {
  description = "Your current public IP"
  value       = chomp(data.http.my_public_ip.response_body)
}

output "ec2_Master_ip" {
  description = "Your Control-plane IP"
  value       = module.master_instance.public_ip[0]
}

output "ec2_Worker_ip" {
  description = "All your worker nodes IPs"
  value       = module.worker_instance.public_ip
}
output "ec2_Jenkins_ip" {
  description = "All your worker nodes IPs"
  value       = module.Jenkins_instance.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}


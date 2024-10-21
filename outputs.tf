output "your_public_ip" {
  description = "Your current public ip"
  value       = "${chomp(data.http.my_public_ip.response_body)}/32"
}


output "ec2_Master_ip" {
  description = "Your Control-plane ip"
  value       = aws_instance.Master_Node.*.public_ip
}

output "ec2_Worker_ip" {
  description = "All your worker nodes ips"
  value       = aws_instance.Worker_Node.*.public_ip
}


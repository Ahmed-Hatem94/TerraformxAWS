output "ec2_public_ip" {
  value = data.http.my_public_ip.response_body
}


output "ec2_Master_ip" {
  value = aws_instance.Master_Node.*.public_ip
}

output "ec2_Worker_ip" {
  value = aws_instance.Worker_Node.*.public_ip
}


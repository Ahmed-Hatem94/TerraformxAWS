output "ec2_public_ip" {
  value = data.http.my_public_ip.response_body
}


output "ec2_kubern_ip" {
  value = aws_instance.Master_Node.*.public_ip
}


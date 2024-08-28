resource "aws_key_pair" "key" {
  key_name   = var.key-name
  public_key = file("${path.module}/my-key.pub")
}


data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com"
}

# Creating a security group to restrict/allow inbound connectivity
resource "aws_security_group" "network-security-group" {
  name        = var.network-security-group-name
  description = "Allow TLS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"]
  }
  ingress {
    description = "internal security group"
    self        = true
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
  }
  egress {
    description = "internet"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Not recommended to add "0.0.0.0/0" instead we need to be more specific with the IP ranges to allow connectivity from.
  tags = {
    Name = "nsg-inbound"
  }

}

resource "aws_instance" "Master_Node" {
  ami                    = var.Master-ami
  instance_type          = var.Master-instance-type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.network-security-group.id]

  #installation in EC2 using .sh script
  user_data = <<EOF
    #!/bin/bash
    sudo hostnamectl set-hostname Master1
    EOF

    tags = {
    Name = "Kube_Master"
  }

}

resource "aws_instance" "Worker_Node" {
  ami                    = var.Master-ami
  instance_type          = var.Master-instance-type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.network-security-group.id]

  #installation in EC2 using .sh script
  user_data = <<EOF
    #!/bin/bash
    sudo hostnamectl set-hostname worker1
    EOF



  tags = {
    Name = "Kube_Worker1"
  }

}


resource "null_resource" "ansible_runner" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${aws_instance.Master_Node.public_ip},${aws_instance.Worker_Node.public_ip},' -u ec2-user --private-key ${path.module}/my-key ${path.module}/ansible/test_ansible.yml > Ansible.txt " 
  }
}
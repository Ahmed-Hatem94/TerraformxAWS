resource "tls_private_key" "priv_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "key" {
  depends_on = [tls_private_key.priv_key]
  key_name   = var.key-name
  public_key = tls_private_key.priv_key.public_key_openssh


}

resource "local_file" "priv_key" {
  depends_on      = [tls_private_key.priv_key]
  filename        = "${path.module}/${var.key-name}.pem"
  content         = tls_private_key.priv_key.private_key_pem
  file_permission = 0600

}

data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
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

  tags = {
    Name = "control-plane"
  }

}

resource "aws_instance" "Worker_Node" {
  count                  = var.Worker-count
  ami                    = var.Worker-ami
  instance_type          = var.Worker-instance-type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.network-security-group.id]

  tags = {
    Name = "worker${count.index}"
  }

}


resource "local_file" "inventory" {
  depends_on = [aws_instance.Master_Node, aws_instance.Worker_Node]
  content = templatefile("${path.module}/ansible/inventory.tpl",
    {
      master = {
        "${aws_instance.Master_Node.tags.Name}" = "${aws_instance.Master_Node.public_ip}"
      }
      worker = {
        for instance in aws_instance.Worker_Node :
        instance.tags.Name => instance.public_ip
      }
    }
  )
  filename = "${path.module}/ansible/inventory.yaml"
}


resource "null_resource" "ansible_runner" {
  depends_on = [local_file.inventory]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/ansible/inventory.yaml --private-key ${path.module}/${var.key-name}.pem ${path.module}/ansible/Prepare.yml > Ansible$(date +'%Y_%m_%d_%I_%M_%p').txt "
  }
}
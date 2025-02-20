locals {
  ami_filter_name = "amzn2-ami-hvm-*-x86_64-gp2"
  ami_owner       = "amazon"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = [local.ami_owner]

  filter {
    name   = "name"
    values = [local.ami_filter_name]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

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

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

module "security_group" {
  source       = "./modules/security_group"
  name         = var.network-security-group-name
  description  = "Allow TLS inbound traffic"
  my_public_ip = "${chomp(data.http.my_public_ip.response_body)}/32"
  tags = {
    Name = "nsg-inbound"
  }
}

module "master_instance" {
  source             = "./modules/ec2_instance"
  ami                = data.aws_ami.latest_amazon_linux.id
  instance_type      = var.Master-instance-type
  key_name           = aws_key_pair.key.key_name
  security_group_ids = [module.security_group.id]
  root_block_device  = var.master_root_block_device
  tags = {
    Name = "control-plane"
  }
}

module "worker_instance" {
  source             = "./modules/ec2_instance"
  ami                = data.aws_ami.latest_amazon_linux.id
  instance_type      = var.Worker-instance-type
  key_name           = aws_key_pair.key.key_name
  security_group_ids = [module.security_group.id]
  instance_count     = var.Worker-count
  root_block_device  = var.worker_root_block_device
  tags = {
    Name = "worker"
  }
}
module "Jenkins_instance" {
  source             = "./modules/ec2_instance"
  ami                = data.aws_ami.latest_amazon_linux.id
  instance_type      = var.Jenkins-instance-type
  key_name           = aws_key_pair.key.key_name
  security_group_ids = [module.security_group.id]
  root_block_device  = var.Jenkins_root_block_device
  tags = {
    Name = "Jenkins"
  }
}

resource "local_file" "inventory" {
  depends_on = [module.master_instance, module.worker_instance, module.Jenkins_instance]
  content = templatefile("${path.module}/ansible/inventory.tpl",
    {
      master = {
        "control-plane" = module.master_instance.public_ip[0]
      }
      Jenkins = {
        "Jenkins" = module.Jenkins_instance.public_ip[0]
      }
      worker = zipmap(
        [for i in range(length(module.worker_instance.public_ip)) : "worker${i}"],
        module.worker_instance.public_ip
      )
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
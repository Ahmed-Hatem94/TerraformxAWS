key-name                    = "my-key"
network-security-group-name = "nsg-inbound"
Master-instance-type        = "t2.medium"
Worker-instance-type        = "t2.medium"
Jenkins-instance-type       = "t2.micro"
Worker-count                = 2
region                      = "us-east-1"

master_root_block_device = {
  volume_type           = "gp2"
  volume_size           = 30
  delete_on_termination = true
}

worker_root_block_device = {
  volume_type           = "gp2"
  volume_size           = 30
  delete_on_termination = true
}
Jenkins_root_block_device = {
  volume_type           = "gp2"
  volume_size           = 16
  delete_on_termination = true
}

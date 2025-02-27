resource "aws_instance" "instance" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    delete_on_termination = var.root_block_device.delete_on_termination
  }

  tags = merge(
    var.tags,
    {
      Name = var.instance_count > 1 ? format("%s-%02d", var.name_prefix, count.index + 1) : var.name_prefix
    }
  )
}

resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }
  ingress {
    description = "internal security group"
    self        = true
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    description = "internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

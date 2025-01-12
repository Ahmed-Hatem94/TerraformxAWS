variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "The description of the security group"
  type        = string
}

variable "my_public_ip" {
  description = "Your public IP address"
  type        = string
}

variable "tags" {
  description = "The tags to associate with the security group"
  type        = map(string)
}

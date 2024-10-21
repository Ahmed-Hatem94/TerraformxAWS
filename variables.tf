variable "key-name" {
  description = "Your SSH-Key name "
  default     = "my-key"
  type        = string
}

variable "network-security-group-name" {
  description = "Your Network security group name"
  default     = "nsg-inbound"
  type        = string
}

variable "Master-ami" {
  description = "AWS ami used for master instance, you can updated to the latest ami"
  default     = "ami-00f251754ac5da7f0"
  type        = string

}

variable "Master-instance-type" {
  description = "AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes "
  default     = "t2.medium"
  type        = string

}

variable "Worker-ami" {
  description = "AWS ami used for Worker instance, you can updated to the latest ami"
  default     = "ami-00f251754ac5da7f0"
  type        = string
}

variable "Worker-instance-type" {
  description = "AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes "
  default     = "t2.medium"
  type        = string
}

variable "Worker-count" {
  description = "Worker nodes count to be deployed"
  type        = number
  default     = "1"
}
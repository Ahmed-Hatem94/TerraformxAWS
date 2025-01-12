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

variable "Master-instance-type" {
  description = "AWS instance type for the master node, the defualt will be t2.medium as it's the least for the kubernetes "
  default     = "t2.medium"
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
  default     = 2
}

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "master_root_block_device" {
  description = "The root block device configuration for the master instance"
  type = object({
    volume_type           = string
    volume_size           = number
    delete_on_termination = bool
  })
  default = {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
}

variable "worker_root_block_device" {
  description = "The root block device configuration for the worker instances"
  type = object({
    volume_type           = string
    volume_size           = number
    delete_on_termination = bool
  })
  default = {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
}
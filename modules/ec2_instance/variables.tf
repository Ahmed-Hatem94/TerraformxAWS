variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the instance"
  type        = list(string)
}

variable "tags" {
  description = "The tags to associate with the instance"
  type        = map(string)
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}

variable "root_block_device" {
  description = "The root block device configuration"
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

variable "name_prefix" {
  description = "Prefix to use for instance names (e.g., 'control-plane' or 'worker')"
  type        = string
}

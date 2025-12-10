variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "Subnet id to launch the instance into"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group ids to attach to the instance"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {}
}

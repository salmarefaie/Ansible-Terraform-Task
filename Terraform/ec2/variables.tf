variable "security_group" {
  type        = string
  description = "security group name"
}

variable "public_cidr" {
  type        = string
  description = "0.0.0.0/0"
}

variable "vpcID" {
  type        = string
  description = "vpc id"
}

variable "ec2_type" {
  type        = string
  description = "instance type"
}

variable "ec2" {
  type        = map(any)
  description = "instance arguments"
}

variable "ami" {
  type        = string
  description = "ami for ec2"
}
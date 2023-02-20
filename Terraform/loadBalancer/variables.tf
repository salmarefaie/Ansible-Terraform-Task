variable "vpcID" {
  type        = string
  description = "vpc id"
}

variable "nexus-id" {
  type        = string
  description = "nexus ec2 id"
}

variable "sonar-id" {
  type        = string
  description = "sonar ec2 id"
}

variable "security_group" {
  type        = string
  description = "security group name"
}

variable "public_cidr" {
  type        = string
  description = "0.0.0.0/0"
}

variable "publicSubnet1" {
  type        = string
  description = "public subnet id 1"
}

variable "publicSubnet2" {
  type        = string
  description = "public subnet id 2"
}

variable "privateSubnet1" {
  type        = string
  description = "private subnet id 1"
}

variable "privateSubnet2" {
  type        = string
  description = "private subnet id 2"

}
variable "port80" {
  type        = number
  description = "port 80"

}

variable "target_type" {
  type        = string
  description = "type is instance (default)"

}

variable "protocol-Http" {
  type        = string
  description = "protocol is http"

}

variable "target_group" {
  type        = string
  description = "name of target group"
}

variable "load_balancer_type" {
  type        = string
  description = "application load balancer"
}

variable "load_balancer_name" {
  type        = string
  description = "name of load balancer"
}

variable "ip_address_type" {
  type        = string
  description = "ipv4"
}

variable "public-subnet-id1" {
  type        = string
  description = "id for public subnet1"
}

variable "public-subnet-id2" {
  type        = string
  description = "id for public subnet2"
}

variable "securityID" {
  type        = string
  description = "id for security group"
}
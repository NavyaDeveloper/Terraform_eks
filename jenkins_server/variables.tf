variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "PUBLIC SUBNETS"
  type        = list(string)
}

variable "instance_type" {
  description = "t2.micro"
  type        = string
}
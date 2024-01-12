variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "PRIVATE-SUBNETS"
  type        = list(string)
}

variable "public_subnets" {
  description = "PUBLIC SUBNETS"
  type        = list(string)
}
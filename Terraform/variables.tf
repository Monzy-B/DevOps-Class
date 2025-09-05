variable "vpc_cidr_block" {
  type        = string
  description = "Cidr block of my aws vpc"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Cidr block of my aws subnet"
}

variable "instance_type" {
  type        = string
  description = "Type Of AWS Instance to Use"
}

variable "ec2_public_key" {
  description = "Public key for EC2 instance SSH access"
  type        = string
}
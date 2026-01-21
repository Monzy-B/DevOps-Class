terraform {
  required_providers {
#    aws = {
 #     source  = "hashicorp/aws"
  #    version = "~> 5.0"
   # }
  #}
  # backend "s3" {
  #   bucket = "ife-devops-class-001"
  #   region = "eu-west-2"
  #   key = "terraform.tfstate"
  #   dynamodb_table = "devop-class"
  #   encrypt = true
  # }
#}

# Configure the AWS Provider
#provider "aws" {
 # region = "eu-west-2"
#}

# Create a VPC
#resource "aws_vpc" "devop-class-vpc" {
 # cidr_block = var.cidr_block
  #tags = {
   # Usage = "Demo"
 # }
#}

#resource "aws_subnet" "devop-class-subnet" {
 # vpc_id     = aws_vpc.devop-class-vpc.id
  #cidr_block = var.subnet_cidr_block

  #tags = {
   # Usage = "Create EC2"
  #}
#}

#resource "aws_internet_gateway" "devop-class-gw" {
 # vpc_id = aws_vpc.devop-class-vpc.id

  #tags = {
   # Name = "main"
  #}
#}

#resource "aws_route_table" "devop-class-route" {
 # vpc_id = aws_vpc.devop-class-vpc.id

  #route {
   # cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.devop-class-gw.id
  #}
#}

#resource "aws_route_table_association" "a" {
 # subnet_id      = aws_subnet.devop-class-subnet.id
  #route_table_id = aws_route_table.devop-class-route.id
#}

#resource "aws_security_group" "allow_ssh" {
 # name        = var.security_group_name
  #description = "Allow SSH inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.devop-class-vpc.id

  #ingress {
   # description = "HTTPS from VPC"
    #from_port   = 443
    #to_port     = 443
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  #ingress {
   # description = "HTTP from VPC"
    #from_port   = 80
    #to_port     = 80
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  #ingress {
   # from_port   = 22
    #to_port     = 22
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  #egress {
   # from_port   = 0
    #to_port     = 0
    #protocol    = "-1"
    #cidr_blocks = ["0.0.0.0/0"]
  #}

  #tags = {
   # Usage = "allow_ssh"
  #}
#}

#resource "aws_key_pair" "devop-class-ssh-key" {
 # key_name   = "deploy-keys"
  #public_key = file("~/.ssh/id_ed25519.pub")
#}

#data "aws_ami" "ubuntu" {
 # most_recent = true

  #filter {
   # name   = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
 # }

  #filter {
   # name   = "virtualization-type"
    #values = ["hvm"]
  #}

  #owners = ["099720109477"] # Canonical
#}

#resource "aws_instance" "devop-class-instance" {
  #ami                         = data.aws_ami.ubuntu.id
 # instance_type               = var.instance_type
  #key_name                    = aws_key_pair.devop-class-ssh-key.key_name
  #vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  #subnet_id                   = aws_subnet.devop-class-subnet.id
  #associate_public_ip_address = true

  #tags = {
   # Usage = "EC2 Demo with Terraform"
  #}
#}

#output "ec2_public_ip" {
 # value = aws_instance.devop-class-instance.public_ip
#}

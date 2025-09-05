resource "aws_vpc" "devops-class-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "devops-class-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.devops-class-vpc.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.devops-class-vpc.id

  tags = {
    Name = "main-gw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devops-class-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}

resource "aws_key_pair" "devops-class-key-pair" {
  key_name   = "devops-class-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.devops-class-vpc.id

  tags = {
    Name = "allow_tls"
  }
}

# ## Security Group Block
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.devops-class-vpc.cidr_block
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.devops-class-vpc.cidr_block
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_ecr_repository" "todo-app" {
  name                 = "todo-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}






resource "aws_iam_role" "ec2_role" {
  name = "ec2-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}



















### EC2 Instance
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "devops-class-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.devops-class-key-pair.id
  subnet_id              = aws_subnet.main.id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true

  user_data = file("${path.module}/userdata.sh")
             
   
  tags = {
    Name = "HelloWorld"
  }
}

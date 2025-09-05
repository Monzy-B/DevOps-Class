output "ec2_public_ip" {
  value = aws_instance.devops-class-instance.public_ip
}

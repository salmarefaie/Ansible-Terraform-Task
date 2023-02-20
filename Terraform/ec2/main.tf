# security group for ec2
resource "aws_security_group" "ec2_sg" {
  name        = var.security_group
  description = var.security_group
  vpc_id      = var.vpcID

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  ingress {
    description = "nexus"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  ingress {
    description = "sonarqube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_cidr]
  }

  tags = {
    Name = var.security_group
  }
}

# install ec2 machines
resource "aws_instance" "ec2" {
  ami                         = var.ami
  for_each                    = var.ec2
  instance_type               = var.ec2_type
  subnet_id                   = each.value.subnetID
  associate_public_ip_address = each.value.publicIP
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "ansible"

  tags = {
    Name = each.key
  }
}


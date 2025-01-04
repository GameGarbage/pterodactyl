provider "aws" {
  profile = "motify-dev"
  region  = "us-east-1"
}

# Find the latest Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID
}


resource "aws_instance" "pterodactyl" {
  instance_type   = "t2.medium"
  ami             = data.aws_ami.ubuntu.id
  key_name        = "dev-key"
  security_groups = ["pterodactyl-sg"]

  # User Data script
  user_data = file("user-data.sh")

  tags = {
    Name = "Pterodactyl-Server"
  }
}

resource "aws_security_group" "pterodactyl-sg" {
  name        = "pterodactyl-sg"
  description = "Security group for Pterodactyl server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

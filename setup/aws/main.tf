provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "pterodactyl" {
  ami           = "ami-12345678" # Replace with the desired AMI (e.g., Ubuntu 20.04)
  instance_type = "t2.medium"
  key_name      = "your-key-name"
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
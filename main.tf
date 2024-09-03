provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_security_group" "appser1_sg" {
  name        = "appser1_security_group"
  description = "Security group for APPSER1"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "appser1" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with the AMI ID you want
  instance_type = "t2.micro"               # Change to your preferred instance type

  security_groups = [aws_security_group.appser1_sg.name]

  tags = {
    Name = "APPSER1"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              EOF
}

output "instance_id" {
  value = aws_instance.appser1.id
}

output "public_ip" {
  value = aws_instance.appser1.public_ip
}

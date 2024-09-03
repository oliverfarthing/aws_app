# Specify the AWS provider and the region where the resources will be deployed.
provider "aws" {
  region = "us-east-1"  # You can change this to your preferred region.
}

# Create a security group to control inbound and outbound traffic to the EC2 instance.
resource "aws_security_group" "appser1_sg" {
  name        = "appser1_security_group"  # Name of the security group.
  description = "Security group for APPSER1"  # Description of what this security group is for.

  # Inbound rule: Allow SSH access (port 22) from anywhere.
  ingress {
    from_port   = 22              # Starting port
    to_port     = 22              # Ending port
    protocol    = "tcp"           # Protocol (TCP in this case)
    cidr_blocks = ["0.0.0.0/0"]   # IP range allowed (0.0.0.0/0 means anywhere)
  }

  # Outbound rule: Allow all outbound traffic.
  egress {
    from_port   = 0               # Starting port
    to_port     = 0               # Ending port
    protocol    = "-1"            # Protocol (-1 means all protocols)
    cidr_blocks = ["0.0.0.0/0"]   # IP range allowed (0.0.0.0/0 means anywhere)
  }
}

# Create an EC2 instance with the specified AMI and instance type.
resource "aws_instance" "appser1" {
  ami           = "ami-0c55b159cbfafe1f0"  # The Amazon Machine Image (AMI) ID for the instance.
  instance_type = "t2.micro"               # The instance type (t2.micro is the free tier eligible type).

  # Associate the instance with the security group created above.
  security_groups = [aws_security_group.appser1_sg.name]

  # Add tags to the instance for identification.
  tags = {
    Name = "APPSER1"  # The name tag for the instance.
  }

  # User data script to run when the instance starts (e.g., creating a simple web page).
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              EOF
}

# Output the instance ID after creation.
output "instance_id" {
  value = aws_instance.appser1.id
}

# Output the public IP address of the instance after creation.
output "public_ip" {
  value = aws_instance.appser1.public_ip
}

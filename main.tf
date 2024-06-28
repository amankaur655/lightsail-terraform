provider "aws" {
  region = "us-east-1"  # Choose your preferred region
}

# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "centos_server" {
  name              = "centos_server"
  availability_zone = "us-east-1a"
  blueprint_id      = "centos_7_2009_01"
  bundle_id         = "micro_1_0"
  key_pair_name     = "aman"

    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y 
              sudo yum install unzip wget httpd -y
              sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
              sudo unzip main.zip
              sudo cp -r static-resume-main/* /var/www/html/  
              sudo systemctl start httpd
              sudo systemctl enable httpd 
              EOF
  tags = {
    Name = "centos_server"
  }
}

output "public_ip" {
  value = aws_lightsail_instance.centos_server.public_ip_address
}
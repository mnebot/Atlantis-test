terraform {
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.12.26"
}

provider "aws" {
  region = "eu-west-3"
}

# website::tag::1:: Deploy an EC2 Instance.
resource "aws_instance" "example" {
  # website::tag::2:: Run an Ubuntu 18.04 AMI on the EC2 instance.
  ami                    = "ami-052f10f1c45aa2155"
  instance_type          = "t2.micro"


  # website::tag::3:: When the instance boots, start a web server on port 8080 that responds with "Hello, World!".
  user_data = <<EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 8080 &
EOF
}



# website::tag::5:: Output the instance's public IP address.
output "public_ip" {
  value = aws_instance.example.public_ip
} 
 

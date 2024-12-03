provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           =  "ami-024fc608af8f886bc" 
  instance_type = "t2.micro"

  tags = {
   Name = "AnandTerraformEC2"
  }
  
  security_groups = ["web_server_sg"]
}

resource "aws_security_group" "web_server_sg" {
  name_prefix = "web_server_sg"
  description = "Security group for the web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_PUBLIC_IP/32"] # Replace this with your public IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
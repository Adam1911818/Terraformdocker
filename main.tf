provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "docker" {
  ami           = "ami-0f58b397bc5c1f2e8"  # Replace with a valid Ubuntu AMI ID in your region
  instance_type = "t2.micro"
  key_name      = "dockeradam"  # Replace with your key pair name (without .pem extension)
  vpc_security_group_ids = ["sg-0d2f4be3ebfc66f11"]  # Replace with your security group ID
  
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
              add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              apt-get update
              apt-get install -y docker-ce
              usermod -aG docker ubuntu
              systemctl enable docker
              systemctl start docker
              docker run -d -p 80:80 --name myapp mydockerimage  # Replace with your Docker image
              EOF

  tags = {
    Name = "MyDockerInstance"
  }
}

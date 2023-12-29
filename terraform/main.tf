data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "tag:Created-by"
    values = [var.createdby]
  }

  filter {
    name   = "tag:Name"
    values = [var.appname]
  }

  owners = ["self"]
}

resource "aws_security_group" "nginx-app-sg" {
  name        = "nginx-app-security-group"
  description = "Allow inbound traffic to nginx 80"

  ingress {
    description = "Nginx App Inbound Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nginx_app"
  }
}

resource "aws_instance" "test_ami" {
  ami                    = data.aws_ami.packer_image.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.nginx-app-sg.id]

  tags = {
    "Name" = var.appname
  }
}

output "public_ip" {
  value = aws_instance.test_ami.public_ip
}

output "public_dns" {
  value = aws_instance.test_ami.public_dns
}

output "nginx_app" {
  value = "http://${aws_instance.test_ami.public_dns}:80"
}
locals {
    vpc_id = "vpc-052f50486de034fa2"
    subnet_id = "subnet-09f66e8dc945fb5ff"
    ssh_user = "ubuntu"
    key_name = "devops"
    private_key_path = "~/Downloads/devops.pem"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "nginx" {
  name = "nginx_access"
  vpc_id = local.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0   # all ports
    to_port = 0    # all ports
    protocol = "-1"  # all protocols
    cidr_blocks = ["0.0.0.0/0"]    # all cidr addresses
  }
}

resource "aws_instance" "nginx" {
  ami                         = "ami-0dba2cb6798deb6d8"
  subnet_id                   = local.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = local.key_name  #key pair

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.nginx.public_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }
}

output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}
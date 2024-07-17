locals {
    vpc_id = "vpc-0dc7ff5bd56061e73"
    subnet_id = "subnet-06d1297753a647bf4"
    ssh_uder = "ubuntu"
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
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
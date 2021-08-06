terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.52.0"
    }
  }
}

//Configuring AWS-Provider
provider "aws" {
  region = var.region
}

//Deploying New VPC
resource "aws_vpc" "vpc-MW" {
  cidr_block = var.vpc
  tags = {
    "Name" = "VPC-MW"
  }
}

//Deploying Iternet Gateway
resource "aws_internet_gateway" "ig-MW" {
  vpc_id = aws_vpc.vpc-MW.id
  tags = {
    "Name" = "IG-MW"
  }
}

//Deploying Subnet
resource "aws_subnet" "subnet-MW" {
  vpc_id                  = aws_vpc.vpc-MW.id
  cidr_block              = var.subnet
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    "Name" = "SNET-MW"
  }
}

//Deploying route table
resource "aws_route_table" "rt-MW" {
  vpc_id = aws_vpc.vpc-MW.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-MW.id
  }
}

//Deploying route table association
resource "aws_route_table_association" "rtas-MW" {
  subnet_id      = aws_subnet.subnet-MW.id
  route_table_id = aws_route_table.rt-MW.id
}

resource "aws_key_pair" "ec2loginkey" {
  key_name = "login-key"
  public_key = file(pathexpand(var.ssh_key_pair_pub))
}

//Deploying EC2 instance
resource "aws_instance" "instance-MW" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg-MW.id]
  subnet_id       = aws_subnet.subnet-MW.id
  associate_public_ip_address = true
  key_name      = aws_key_pair.ec2loginkey.key_name
  volume_tags = {
    "Name" = "VOLUME-MW"
  }
  
  user_data = file("setup.sh")

  tags = {
    "Name" = "MediWiki-Host"
  }

  provisioner "file" {
    source = "ansible/"
    destination = "/home/centos/"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file(pathexpand(var.ssh_key_pair))
      host        = self.public_ip
    }
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum install -y wget",
      "sudo cd /tmp",
      "sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm", 
      "sudo rpm -ivh epel-release-latest-7.noarch.rpm",
      "sudo yum install ansible -y",
    ]
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file(pathexpand(var.ssh_key_pair))
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${aws_instance.instance-MW.public_ip}' >> /home/centos/inventory",
      "echo '[defaults]' >> /home/centos/ansible.cfg", 
      "echo 'inventory = ./inventory' >> /home/centos/ansible.cfg",
      "echo 'host_key_checking = False' >> /home/centos/ansible.cfg",
      "echo '#interpreter_python = /usr/bin/python3' >> /home/centos/ansible.cfg"
    ]
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file(pathexpand(var.ssh_key_pair))
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 120; ansible-playbook -i /home/centos/inventory main.yml --extra-vars 'ansible_user=wikiuser ansible_password=wikiuser'"
    ]
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file(pathexpand(var.ssh_key_pair))
      host        = self.public_ip
    }
  }
  
}
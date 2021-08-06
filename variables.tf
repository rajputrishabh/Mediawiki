variable "region" {
  description = "Setting up default region for EC2 instance deployment"
  default     = "us-east-2"
}

variable "vpc" {
  description = "VPC details"
  default     = "10.0.0.0/16"
}

variable "subnet" {
  description = "Subnet details"
  default     = "10.0.0.0/24"
}

variable "availability_zone" {
  description = "Availability-set details"
  default     = "us-east-2a"
}

variable "ami" {
  description = "AMI details"
  default     = "ami-01e36b7901e884a10"
}

variable "instance_type" {
  description = "Instance type details"
  default     = "t2.micro"
}

variable "ssh_key_pair" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_key_pair_pub" {
  default = "~/.ssh/id_rsa.pub"
}
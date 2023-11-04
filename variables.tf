# Declare variables
variable "aws_region" {
  description = "AWS region where the EC2 instance will be created."
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance."
}

variable "instance_type" {
  description = "Instance type for the EC2 instance."
}

variable "key_name" {
  description = "Name of the SSH key pair."
}

variable "instance_tags" {
  description = "Tags to assign to the EC2 instance."
  type        = map(string)
}

variable "instance_name" {
  description = "Name of the EC2 instance."
}

variable "subnet_id" {
  description = "AWS subnet where the EC2 instance will be created."
}

variable "vpc_id" {
  description = "AWS VPC where the EC2 instance will be created."
}

variable "master_count" {
  description = "Number of Master EC2 instance count."
}

variable "worker_count" {
  description = "Number of Worker EC2 instance count"
}


variable "vpc_private_subnets" {
  type    = list(string)  
  default = []
}

variable "vpc_public_subnets" {
  type    = list(string)
  default = []
}


variable "ssk_key_pair_name" {
  description = "ssk_key_pair_name"
}


variable "my_public_ip_cidr" {
  description = "my_public_ip_cidr"
}

variable "environment" {
  description = "environment"
}

variable "vpc_subnet_cidr" {
  description = "vpc_subnet_cidr"
}



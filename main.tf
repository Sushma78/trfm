module "master" {
  source          = "./modules/ec2"
  subnet_id       = var.subnet_id # Replace with the actual subnet ID
  master_count    = var.master_count                   # Replace with the desired master count
  instance_ami    = var.instance_ami       # Replace with the desired AMI ID
  instance_tags   = {                    # Replace with the desired instance tags
    Name = "MasterInstance"
  }
  instance_name   = var.instance_name    # Replace with the desired instance name
  vpc_id          = var.vpc_id       # Replace with the actual VPC ID
  worker_count    = var.worker_count                   # Replace with the desired worker count
  aws_region      = var.aws_region   # Replace with the desired AWS region
  instance_type   = var.instance_type           # Replace with the desired instance type
  key_name        = var.key_name  
}

module "worker" {
  source          = "./modules/ec2"
  subnet_id       = var.subnet_id # Replace with the actual subnet ID
  master_count    = var.master_count                   # Replace with the desired master count
  instance_ami    = var.instance_ami         # Replace with the desired AMI ID
  instance_tags   = {                      # Replace with the desired instance tags
    Name = "WorkerInstance"
  }
  instance_name   = var.instance_name     # Replace with the desired instance name
  vpc_id          = var.vpc_id       # Replace with the actual VPC ID
  worker_count    = var.worker_count                   # Replace with the desired worker count
  aws_region      = var.aws_region   # Replace with the desired AWS region
  instance_type   = var.instance_type           # Replace with the desired instance type
  key_name        = var.key_name  

}


module "security_groups" {
  source   = "./modules/sg_group"
  subnet_id       = var.subnet_id # Replace with the actual subnet ID
  master_count    = var.master_count                   # Replace with the desired master count
  instance_ami    = var.instance_ami 

  instance_tags   = {                            # Replace with the desired instance tags
    Name = "SecurityGroupInstance"
  }

  instance_name   = var.instance_name     # Replace with the desired instance name
  vpc_id          = var.vpc_id       # Replace with the actual VPC ID
  worker_count    = var.worker_count                   # Replace with the desired worker count
  aws_region      = var.aws_region   # Replace with the desired AWS region
  instance_type   = var.instance_type           # Replace with the desired instance type
  key_name        = var.key_name  
}

module "ec2_autoscalling" {
  source   = "./modules/ec2_autoscalling"
  instance_tags  = { key = "value" }     # Replace with actual instance tags.
  instance_name  = var.instance_name     # Replace with an actual instance name.
  vpc_id         = var.vpc_id                           # Replace with your VPC ID.
  master_count   = var.master_count                     # Replace with the desired master count.
  aws_region     = var.aws_region                       # Replace with your desired AWS region.
  instance_ami   = var.instance_ami                     # Replace with your desired AMI ID.
  instance_type  = var.instance_type                    # Replace with your desired instance type.
  key_name       = var.key_name                         # Replace with your key pair name.
  worker_count   = var.worker_count                     # Replace with the desired worker count.
  subnet_id      = var.subnet_id  
  
}


module "k8s" {
  ssk_key_pair_name      = var.ssk_key_pair_name
  my_public_ip_cidr      = var.my_public_ip_cidr
  environment            = var.environment
  vpc_id                 = var.vpc_id 
  vpc_private_subnets    = var.vpc_private_subnets
  vpc_public_subnets     = var.vpc_public_subnets
  vpc_subnet_cidr        = var.vpc_subnet_cidr
 
  install_nginx_ingress  = true
  source                 = "github.com/garutilorenzo/k8s-aws-terraform-cluster"
}



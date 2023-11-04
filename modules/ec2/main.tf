# EC2 Instances
resource "aws_instance" "kubernetes_master" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  tags = {
    Name = var.instance_name
  }
}



resource "aws_instance" "kubernetes_worker" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  tags = {
    Name = var.instance_name
  }
}





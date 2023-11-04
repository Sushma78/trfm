# Auto Scaling for Worker Instances based on CPU Utilization


resource "aws_security_group" "kubernetes" {
  name        = "kubernetes-security-group"
  description = "Security group for Kubernetes workers"
  # Add your security group rules and configurations here
}


resource "aws_launch_configuration" "kubernetes_worker_launch_config" {
  name                        = "kubernetes-worker-launch-config"
  image_id                    = var.instance_ami  # Replace with your desired AMI ID for Kubernetes worker
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.kubernetes.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "kubernetes" {
  desired_capacity     = 1  # Initial desired capacity
  max_size             = 5  # Maximum number of instances
  min_size             = 1  # Minimum number of instances
  vpc_zone_identifier  = [var.subnet_id]  # Replace with the subnet IDs
  health_check_type    = "EC2"
  health_check_grace_period = 300
  force_delete          = true
  launch_configuration = aws_launch_configuration.kubernetes_worker_launch_config.id

  tag{
    key                 = "Name"
    value               = "KubernetesWorker"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "scale-up-policy"
  scaling_adjustment      = 1  # Adjust this value as needed
  adjustment_type         = "ChangeInCapacity"
  cooldown               = 300  # Adjust this value as needed
  autoscaling_group_name = aws_autoscaling_group.kubernetes.name  # Provide the name of your Auto Scaling group
}


resource "aws_cloudwatch_metric_alarm" "worker_cpu_alarm" {
  alarm_name          = "worker-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"  # Modify threshold as needed
  alarm_description   = "This metric checks the worker CPU utilization."

  alarm_actions = [aws_autoscaling_policy.scale_up_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.kubernetes.id
  }
}


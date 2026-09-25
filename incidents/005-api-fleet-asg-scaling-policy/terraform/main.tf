terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ------------------------------------------------------------
# AMI
# ------------------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }
}

# ------------------------------------------------------------
# Networking
# ------------------------------------------------------------

resource "aws_vpc" "api_lab" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name     = "incident-005-api-vpc"
    Incident = "005"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.api_lab.id
  cidr_block              = "10.50.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name     = "incident-005-public-a"
    Incident = "005"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.api_lab.id
  cidr_block              = "10.50.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name     = "incident-005-public-b"
    Incident = "005"
  }
}

resource "aws_internet_gateway" "api_lab" {
  vpc_id = aws_vpc.api_lab.id

  tags = {
    Name     = "incident-005-igw"
    Incident = "005"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.api_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.api_lab.id
  }

  tags = {
    Name     = "incident-005-public-rt"
    Incident = "005"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# ------------------------------------------------------------
# Security Groups
# ------------------------------------------------------------

resource "aws_security_group" "alb" {
  name        = "incident-005-alb-sg"
  description = "Allow HTTP traffic to the Incident 005 ALB"
  vpc_id      = aws_vpc.api_lab.id

  ingress {
    description = "HTTP from internet"
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
    Name     = "incident-005-alb-sg"
    Incident = "005"
  }
}

resource "aws_security_group" "api" {
  name        = "incident-005-api-sg"
  description = "Allow ALB traffic to API instances"
  vpc_id      = aws_vpc.api_lab.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "incident-005-api-sg"
    Incident = "005"
  }
}

# ------------------------------------------------------------
# Application Load Balancer
# ------------------------------------------------------------

resource "aws_lb" "api" {
  name               = "incident-005-api-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name     = "incident-005-api-alb"
    Incident = "005"
  }
}

resource "aws_lb_target_group" "api" {
  name     = "incident-005-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.api_lab.id

  # RFC #30 D2:
  # Replace round_robin with least_outstanding_requests.
  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name     = "incident-005-api-tg"
    Incident = "005"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

# ------------------------------------------------------------
# Launch Template
# ------------------------------------------------------------

resource "aws_launch_template" "api" {
  name_prefix   = "incident-005-api-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.api.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <title>Incident 005 API Fleet</title>
      </head>
      <body>
        <h1>Incident #005 API Fleet</h1>
        <p>ASG target-tracking lab is healthy.</p>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name     = "incident-005-api"
      Incident = "005"
    }
  }

  tags = {
    Name     = "incident-005-api-launch-template"
    Incident = "005"
  }
}

# ------------------------------------------------------------
# Auto Scaling Group
# ------------------------------------------------------------

resource "aws_autoscaling_group" "api" {
  name = "incident-005-api-asg"

  min_size         = 1
  desired_capacity = 1
  max_size         = 3

  vpc_zone_identifier = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  target_group_arns = [
    aws_lb_target_group.api.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 180

  launch_template {
    id      = aws_launch_template.api.id
    version = "$Latest"
  }

  # RFC #30 D4:
  # Enable native AWS/AutoScaling fleet-size metrics.
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  tag {
    key                 = "Name"
    value               = "incident-005-api"
    propagate_at_launch = true
  }

  tag {
    key                 = "Incident"
    value               = "005"
    propagate_at_launch = true
  }
}

# ------------------------------------------------------------
# Target-Tracking Scaling Policy
# ------------------------------------------------------------

resource "aws_autoscaling_policy" "api_cpu_target" {
  name                   = "incident-005-api-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.api.name

  # RFC #30 D1:
  # Replace separate SimpleScaling policies with one
  # target-tracking policy.
  policy_type = "TargetTrackingScaling"

  estimated_instance_warmup = var.estimated_instance_warmup

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_cpu_utilization
  }
}

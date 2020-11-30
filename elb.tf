resource "aws_security_group" "elb-sg" {
  name   = "elb-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-demo-app"

  subnets         = [aws_subnet.public_subnet_1.id,]
  security_groups = [aws_security_group.elb-sg.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = 1
  instances           = [aws_instance.application_server.id,]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

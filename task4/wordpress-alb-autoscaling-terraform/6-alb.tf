
resource "aws_lb_target_group" "alb-tg" {
  name     = "wordpress-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default_vpc.id
}

resource "aws_lb_target_group_attachment" "alb-tg-attachment" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.wordpress_server.id
  port             = 80
}


resource "aws_lb" "load_balancer" {
  name               = "wordpress-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wordpress_alb_sg.id]
  subnets            = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
  # enable_deletion_protection = true

  # access_logs {
  #   bucket  = "alb-logs-nexus"
  #   prefix  = "logs"
  #   enabled = true
  # }

  tags = {
    Name = "wordpress-alb"
    Environment = "production"
  }
}





# module "wordpress-alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 6.0"

#   name = "wordpress-alb"

#   load_balancer_type = "application"

#   vpc_id             = aws_default_vpc.default_vpc.id
#   subnets            = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
#   security_groups    = [aws_security_group.wordpress_alb_sg.id]

#   # depends_on = [module.ec2_instance]

#   target_groups = [
#     {
#       name_prefix      = "pref-"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = [
#         {
#           target_id = aws_instance.wordpress-server.id
#           port = 80
#         }
#       ]
#     }
#   ]


#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

#   tags = {
#     Terraform = true
#     Name = "wordpress-alb"
#   }
# }
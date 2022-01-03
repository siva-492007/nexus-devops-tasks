resource "aws_security_group" "wordpress_alb_sg" {
  name        = "wordpress-alb-sg"
  description = "allow http access for alb"

  ingress {
    description      = "http for wordpress alb"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = true
    Name = "wordpress-alb-sg"
  }
}


resource "aws_security_group" "wordpress_server_sg" {
  name        = "wordpress-server-sg"
  description = "allow traffic only from and to alb"

  ingress {
    description      = "http from wordpress alb"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # cidr_blocks      = [aws_security_group.wordpress_alb_sg.id]
  }

  ingress {
    description      = "allow ssh connection"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # cidr_blocks      = [aws_security_group.wordpress_alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # cidr_blocks      =  [aws_security_group.wordpress_alb_sg.id]
  }

  tags = {
    Terraform = true
    Name = "wordpress-alb-sg"
  }
}
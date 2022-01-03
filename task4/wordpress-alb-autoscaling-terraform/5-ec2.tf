resource "aws_instance" "wordpress_server" {
  ami                    = "ami-04505e74c0741db8d"
  instance_type          = "t2.micro"
  key_name               = "myKeyPair"
  monitoring             = true
  vpc_security_group_ids     = [aws_security_group.wordpress_server_sg.id]

   provisioner "local-exec" {
    command = "ansible-playbook playbook.yml"
    working_dir = "./ansible-provisioner/"
    on_failure = continue
  }

  tags = {
    Name = "wordpress-server"
    Terraform   = "true"
    Environment = "wordpress"
  }
}
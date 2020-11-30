resource "aws_security_group" "application_server-sg" {
  name   = "application_server-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "application_server" {
  ami                         = "ami-042b34111b1289ccd"
  instance_type               = "t2.micro"
  key_name                   = var.PEM_FILE_BASTIAN
  subnet_id = aws_subnet.private_subnet_1.id
  vpc_security_group_ids             = [aws_security_group.application_server-sg.id]
  user_data = file("userdata.sh")
  tags = {
    Name = "application_server_demo-app"
  }
}

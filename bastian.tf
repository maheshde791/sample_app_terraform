resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = "ami-042b34111b1289ccd"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                   = var.PEM_FILE_BASTIAN
  subnet_id = aws_subnet.public_subnet_1.id
  vpc_security_group_ids             = [aws_security_group.bastion-sg.id,]
  tags = {
    Name = "Bastian-host_demo-app"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "research_sg" {
  name = "research_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "research_vm" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.research_sg.id]

  user_data = file("setup.sh")

  tags = {
    Name = "Research-Jupyter-VM"
  }
}

output "public_ip" {
  value = aws_instance.research_vm.public_ip
}

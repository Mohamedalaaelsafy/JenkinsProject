resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "aws_key" {
  key_name   = "jenkins"
  public_key = tls_private_key.example.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.example.private_key_pem}' > ./jenkins.pem"
  }
}

resource "aws_instance" "ec2_public" {
  ami                         = "ami-09d56f8956ab235b3"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.aws_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data = <<EOF
    sudo apt install software-properties-common apt-transport-https -y
    sudo add-apt-repository ppa:openjdk-r/ppa -y
    sudo apt install openjdk-11-jdk -y
  EOF
    tags = {
    Name = "Jenkins-agent"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ./ec2_public_ip && ./replace_ip.sh && cd ansible && ansible-playbook playbook.yml"
  }
}

resource "aws_security_group" "sg" {
  name        = "Jenkins-agent"
  description = "allow port 22"
  vpc_id      = "vpc-0c62c8847f93894c8"

  ingress {
    description = "allow port 22"
    from_port   = 22
    to_port     = 22
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
    Name = "Jenkins-agent"
  }
}
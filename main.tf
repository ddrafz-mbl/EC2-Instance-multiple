provider "aws" {
  region  = var.region
}

resource "aws_security_group" "Jenkinsec2" {
  name = "Dev-JenkinsEC2"

  ingress {
    from_port   = 8080
    protocol    = "tcp"    
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

resource "aws_instance" "Jenkins-EC2" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  count                  = var.ec2_count
  vpc_security_group_ids = [aws_security_group.Jenkinsec2.id]
  key_name               = "linux-key"

  tags = {
    Name = "${var.environment}.${var.product}-${count.index+1}"
  }
  user_data = file("userdata.sh")

}


data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]

}

output "jenkins_endpoint" {
  value = formatlist("http://%s:%s/", aws_instance.Jenkins-EC2.*.public_ip, "8080")
}
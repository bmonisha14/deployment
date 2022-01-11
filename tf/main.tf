provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app-server" {
  ami = "ami-0ed9277fb7eb570c9"
  availability_zone = "us-east-1d"
  subnet_id = "subnet-51054b70"
  instance_type = "${var.instance_type}"
  key_name = "monidevops"
  vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
 
  tags = {
    Name = "app-server"
  }
}

resource "aws_security_group" "web-sg" {
  name = "web-sg"
  description = "app server security group"
  vpc_id = "vpc-e3c65a9e"
  tags = {
    Name = "web-sg"
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

resource "aws_ebs_volume" "appserver-vol" {
  availability_zone = "us-east-1d"
  size = 10
  tags = {
    Name = "appserver"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.appserver-vol.id}"
  instance_id = "${aws_instance.app-server.id}"
}

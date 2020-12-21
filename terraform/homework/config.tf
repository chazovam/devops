provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = "vpc-97a57bea"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {

  connection {
    host = "${self.public_ip}"
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/my_keypair.pem")}"
  }

  instance_type = "t2.nano"
  ami = "ami-00ddb0e5626798373"
  key_name = "my_keypair"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "subnet-2ac49667"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
      "sudo service nginx start",
      "sudo chmod -R a+rw /var/www/html/",
    ]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/var/www/html/index.nginx-debian.html"
  }
}

variable "key_name" {
  default = "my_key"
}

variable "region" {
  default = "us-east-1"
}

resource "tls_private_key" "aws_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.aws_key.public_key_openssh}"
}

resource "local_file" "private_key" { 
  filename = "${var.key_name}.pem"
  content = tls_private_key.aws_key.private_key_pem
  file_permission = "400"
}

resource "local_file" "public_key" { 
  filename = "${var.key_name}"
  content = tls_private_key.aws_key.public_key_openssh
  file_permission = "400"
}

provider "aws" {
  region = "${var.region}"
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
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "instance" {
  count = 2

  connection {
    host = "${self.public_ip}"
    type = "ssh"
    user = "ubuntu"
    private_key = "${tls_private_key.aws_key.private_key_pem}"
  }

  instance_type = "t2.nano"
  ami = "ami-00ddb0e5626798373"
  key_name = "${aws_key_pair.generated_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "subnet-2ac49667"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install python python-pip",
      "sudo pip install docker-py"
    ]
  }

}

# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      builder_ip = aws_instance.instance[0].public_ip
      web_ip = aws_instance.instance[1].public_ip
    }
  )
  filename = "hosts"
  file_permission = "666"
}
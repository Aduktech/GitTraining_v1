# Configure the AWS provider
provider "aws" {
    region = "us-west-2"
}

# create a new VPC 
resource "aws_vpc" "ml_vpc" {
    cidr_block = "10.0.0/0"
}

# create a new subnet
resource "aws_subnet" "ml_subnet" {
    vpc_id              = aws_vpc.ml_vpc.id
    cidr_block          = "10.0.1.0/24"
    availability_zone   = "us-west-2"
}

# create a new security Group 
resource "aws_security_group" "ml_sg" {
    vpc_id = aws_vpc.ml_vpc.id"

    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8888
        to_port   = 8888
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# create a new EC2 instance
resource "aws_instance" "ml_instance" {
    ami             = "ami-0c55b159cbfafe1f0"  # ubuntu 20.04 LTS
    instance_type   = "p2.xlarge" #GPU instance type 
    subnet_id       = aws_subnet.ml_subnet.id
    vpc_security_group_ids = [aws_security_group.ml_sg.id]

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y python3-pip 
                sudo pip3 install tensorflow keras scikit-learn jupyter
                sudo jupyter notebook --allow-root --ip=0.0.0.0 --port=8888
                EOF
    
    tags = {
        Name = "ml_instance"
    }
}

# output the public IP address of the instance 
output "instance_public_ip" {
    value = aws_instance.ml_instance.public_ip 
}
# Configure the aws provider
provider "aws" {
    region = "us-west-2"
}

# Create a new VPC
resource "aws_vpc" "custom" {
    cidr_block = "10.0.0.0/16" 
}

# Create a new subnet
resource "aws_subnet" "custom_subnet" {
    vpc_id      = aws_vpc.custom_subnet.id
    cidr_block  = "10.0.1.0/24"
    availability_zone = "us-west-2a"
}

# Create a new security group
resource "aws_security_group" "custom_Sec_group" {
    vpc_id = "aws_vpc.custom_Sec_group.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
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

# Create a new EC2 instance
resource "aws_instance" "MyNewInstance" {
    ami                     = "ami-0c55b159cbfafe1f0"  # ubuntu 20.04 LTS
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.custom_Sec_group.id]

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                echo "<html><body><h1> Hello World!</h1></body></html>" | sudo tee /var/www/html/index.html
                EOF
    
    tags = {
        Name = "Aduktech-instance"
    }
}

# output the public IP address of the instance
output "instance_public_ip" {
    value = "aws_instance.MyNewInstance.instance_public_ip
}
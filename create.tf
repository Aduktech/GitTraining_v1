resource "aws_instance" "MyInstance" {
    ami            = "ami-..."
    instance_type  = "t2.micro"
}

variables "aws_region" {
    type        = string
    default     = "us-east-1"
    description = "t2.micro"
}

// output value
output "instance_id" {
    value     = aws_instance.MyInstance.id
    description = "ID of the EC2 instance"
}

provider "aws" {
    region = "us-east-1"
  }

resource "aws_insta" "ec2" {
    ami           = "ami-02396cdd13e9a1257"
    instance_type = "t2.micro"
    tags          = {
        Name      =  "My Ec2 instance"
    }
  
}
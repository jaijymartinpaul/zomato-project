variable "project_name"{
    default = "zomato"
}

variable "project_env"{
    default = "prod"
}

variable "instance_type"{
    default = "t2.micro"
}

variable "instance_ami"{
    default = "ami-08df646e18b182346"
}

resource "aws_security_group" "webserver" {

  name        = "webaccess-${var.project_name}-${var.project_env}"
  description = "Allow 80,443,22 traffic"


  ingress {

    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {

       Name = "webserver-${var.project_name}-${var.project_env}"
       project = var.project_name
       env = var.project_env
  }

}

# --------------------------------------------------------------
# Creating Ec2 Instance
# --------------------------------------------------------------

resource "aws_instance"  "webserver" {
    
    ami                    =  var.instance_ami
    instance_type          =  var.instance_type
    key_name               =  "devops-class"
    vpc_security_group_ids =  [ aws_security_group.webserver.id ]
    user_data              = file("setup.sh")

    tags = {
      
       Name = "webserver-${var.project_name}-${var.project_env}"
       project = var.project_name
       env = var.project_env
  }
}


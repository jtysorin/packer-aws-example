variable "aws_region" {
  type    = string
  default = "${env("AWS_REGION")}"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type    = string
  default = "vpc-001aeac8934f955e7"
}

variable "subnet_id" {
  type    = string
  default = "subnet-00d27958f9ad6729c"
}

variable "tags" {
  type = map(string)
  default = {
    "Name"        = "nginx"
    "Environment" = "Production"
    "Release"     = "Latest"
    "Created-by"  = "Sorin"
  }
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}
variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "appname" {
  type        = string
  default = "nginx"
}

variable "createdby" {
  type        = string
  default = "Sorin"
}
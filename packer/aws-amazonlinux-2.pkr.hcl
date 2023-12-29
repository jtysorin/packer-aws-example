data "amazon-ami" "amazon-linux-2" {
  filters = {
    name                = "amzn2-ami-kernel-5.10-hvm-2.*-x86_64-gp2"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  owners      = ["amazon"]
  most_recent = true
  region      = var.aws_region
}

source "amazon-ebs" "amazon-ebs-amazonlinux-2" {
  ami_name                    = "packer-amazonlinux-2-${local.timestamp}"
  ami_description             = "Packer - Amazon Linux 2"
  ami_regions                 = [var.aws_region]
  ami_virtualization_type     = "hvm"
  associate_public_ip_address = true
  force_delete_snapshot       = true
  force_deregister            = true
  instance_type               = var.instance_type
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.amazon-linux-2.id
  spot_price                  = "0"
  ssh_timeout                 = "15m"
  ssh_username                = var.ssh_username
  tags                        = var.tags
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
}

build {
  sources = [
    "source.amazon-ebs.amazon-ebs-amazonlinux-2"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo systemctl status nginx"
    ]
  }

  error-cleanup-provisioner "shell-local" {
    inline = ["echo I am error-cleanup-provisoner"]
  }

  post-processor "manifest" {}
}
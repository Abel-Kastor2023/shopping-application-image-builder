packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "image" {
  ami_name      = local.image_name
  source_ami    = var.ami_id
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"

  tags = {
    Name    = local.image_name
    Project = var.project_name
    Environment = var.project_environment
  }
}

build {
  sources = [ "source.amazon-ebs.image" ]

  provisioner "shell" {
    script           = "./provision.sh"
    execute_command  = "sudo {{.Path}}"
  }

  provisioner "file" {
    source      = "../website"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo cp -r /tmp/website/* /var/www/html",
      "sudo chown -R apache:apache /var/www/html/",  
      "sudo rm -rf /tmp/website"
    ]
  }
}

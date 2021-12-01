packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "python" {
  ami_name      = "packer-linux-aws-python-app"
  instance_type = "t2.micro"
  region        = "us-east-1"
  force_deregister = true
  force_delete_snapshot = true
  source_ami_filter {
    filters = {
      name                = "packer-linux-aws-python"
    }
    most_recent = true
    owners      = ["self"]
  }
  ssh_username = "ec2-user"
  
}



build {
  sources = [
    "source.amazon-ebs.python"
  ]
  provisioner "ansible" {
    playbook_file = "./providers/ansible/install_app.yaml"

  }
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "tomcat" {
  ami_name      = "packer-linux-aws-tomcat-app"
  instance_type = "t2.micro"
  region        = "us-east-1"
  iam_instance_profile = "EC2-compliance"
  force_deregister = true
  force_delete_snapshot = true
  source_ami_filter {
    filters = {
      name                = "packer-linux-aws-tomcat"
    }
    most_recent = true
    owners      = ["self"]
  }
  ssh_username = "ec2-user"
  
}



build {
  sources = [
    "source.amazon-ebs.tomcat"
  ]
  provisioner "ansible" {
    playbook_file = "./providers/ansible/install_app.yaml"

  }
}

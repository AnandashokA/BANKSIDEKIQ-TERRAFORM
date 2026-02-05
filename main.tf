provider "aws" {
    region = var.aws_region
}
data "aws_ami" "amzn_linux" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
    owners = ["099720109477"]

}
# EC2 insance
resource "aws_instance" "ami_builder" {
  ami = data.aws_ami.amzn_linux.id
  instance_type = var.instance_type
  key_name = var.key_name
#   vpc_security_group_ids = [var.ssh_sg_id]
#   subnet_id = var.subnet_id

  provisioner "remote-exec" {
    inline = [
        #installing dependencies
        "sudo apt update",  
        "sudo apt install -y curl gnupg2 build-essential libssl-dev libreadline-dev zlib1g-dev",
        #installing rvm and ruby
        "gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB",
        "\\curl -sSL https://get.rvm.io | bash -s stable --ruby=3.3.8",

        #load rvm
        "source ~/.rvm/scripts/rvm",
        #create directory
        "sudo mkdir -p /var/www/apps/banks/current",
        "sudo chown -R ubuntu:ubuntu /var/www",
        #Environment variables
        "echo 'export PATH=\"$PATH:$HOME/.rvm/bin\"' >> ~/.bashrc", 
        "echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc",
        "echo 'cd /var/www/apps/banks/current' >> ~/.bashrc",
        "echo 'export RAILS_ENV=production' >> ~/.bashrc",
        "echo 'export ENV_PATH=contact' >> ~/.bashrc",

        #Sidekiq setup

    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("/home/francium/Downloads/aws-course/EC2TUT.pem")
    }
  }

  tags={
    Name = "Banks-Sidekiq-AMI-builder-instance"   
  }

}


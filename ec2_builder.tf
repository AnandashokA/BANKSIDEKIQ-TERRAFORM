# resource "aws_instance" "ec2_ami_builder" {
#     ami = data.aws_ami.amzn_linux.id
#     instance_type  = var.instance_type
#     key_name = var.key_name

# }
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "Instance type for building the custom AMI"
  type        = string
  default     = "t3.micro"
}
variable "key_name" {
    description = "key pair name for SSH access to the EC2 instance"
    # type = string
    default = "EC2TUT"
}
variable "ssh_sg_id" {
  description = "Security group allowing SSH"
  type        = string
}

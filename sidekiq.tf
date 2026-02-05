resource "null_resource" "Sidekiq_service" {
    depends_on = [aws_instance.ami_builder]
    provisioner "file" {
        source = "sidekiq.service"
        destination = "/tmp/sidekiq.service"   

        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("/home/francium/Downloads/aws-course/EC2TUT.pem")
            host = aws_instance.ami_builder.public_ip
        }   
    }
    provisioner "remote-exec" {
        inline = [
            "sudo cp /tmp/sidekiq.service /etc/systemd/system/sidekiq.service",
            "sudo chmod 644 /etc/systemd/system/sidekiq.service",
            "sudo systemctl daemon-reload",
            "sudo systemctl enable sidekiq.service"
        ]
        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = file("/home/francium/Downloads/aws-course/EC2TUT.pem")
            host = aws_instance.ami_builder.public_ip
        }
    }
}
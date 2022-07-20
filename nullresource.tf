resource "null_resource" "file-remote" {
  count = var.environment == "prod" ? 3 : 1

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Terraform.pem")
      host        = element(aws_instance.public-instance.*.public_ip, count.index)
    }
  }

  provisioner "file" {
    source      = "sshd_config"
    destination = "/tmp/sshd_config"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Terraform.pem")
      host        = element(aws_instance.public-instance.*.public_ip, count.index)
    }
  }


  provisioner "remote-exec" {
    inline = [
      "sleep 35",
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo rm -rf /etc/ssh/sshd_config",
      "sudo cp /tmp/sshd_config /etc/ssh/sshd_config",
      "sudo service sshd restart"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Terraform.pem")
      host        = element(aws_instance.public-instance.*.public_ip, count.index)
    }
  }

#PROVISIONERS FOR PRIVATE INSTANCES

/*  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      bastion_user        = "ubuntu"
      bastion_private_key = file("Terraform.pem")
      bastion_host        = element(aws_instance.public-instance.*.public_ip, count.index)
      #host = aws_eip.nat-eip.public_ip
    }
  }

  provisioner "file" {
    source      = "sshd_config"
    destination = "/tmp/sshd_config"
    connection {
      type        = "ssh"
      bastion_user        = "ubuntu"
      bastion_private_key = file("Terraform.pem")
      bastion_host        = element(aws_instance.public-instance.*.public_ip, count.index)
      #host = aws_eip.nat-eip.public_ip 
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 35",
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo rm -rf /etc/ssh/sshd_config",
      "sudo cp /tmp/sshd_config /etc/ssh/sshd_config",
      "sudo service sshd restart"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Terraform.pem")
      #host        = element(aws_instance.private-instance.*.private_ip, count.index)
      host = aws_eip.nat-eip.public_ip
    }
  }

*/


  provisioner "local-exec" {
    command = <<EOH
      echo "${element(aws_instance.public-instance.*.public_ip, count.index)}" >> public_server_details_001 && echo "${element(aws_instance.public-instance.*.private_ip, count.index)}" >> public_server_details_002 && echo "Welcome"
      EOH
  }

}
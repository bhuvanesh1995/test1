#!/bin/bash
apt update && apt install -y unzip net-tools jq
#echo "<h1>${var.vpc_name}-Public-Server-${count.index}</h1" | sudo tee /var/www/html/index.nginx-debian.html
#echo "<div><h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1></div>" >> /var/www/html/index.nginx-debian.html
cd /tmp
wget https://releases.hashicorp.com/terraform/1.2.1/terraform_1.2.1_linux_amd64.zip
wget https://releases.hashicorp.com/packer/1.8.0/packer_1.8.0_linux_amd64.zip
unzip terraform_1.2.1_linux_amd64.zip 
unzip packer_1.8.0_linux_amd64.zip
sudo chmod 777 terraform && mv terraform /usr/local/bin
sudo chmod 777 packer && mv packer /usr/local/bin
rm -rf terraform_1.2.1_linux_amd64.zip
rm -r packer_1.8.0_linux_amd64.zip
cd /
terraform version
packer version
sudo useradd -m adminuser
echo "adminuser:Terraform@123456" | sudo chpasswd

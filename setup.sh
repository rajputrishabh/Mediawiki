#! /bin/bash
sudo useradd wikiuser
echo -e 'wikiuser\nwikiuser' | sudo passwd wikiuser
echo 'wikiuser ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wikiuser
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd.service
sudo yum install -y python3
sudo yum install -y vim
sudo yum update -y
#!/bin/bash

sudo apt update

sudo apt install -y vsftpd
sudo apt install  -y apache2
sudo apt install -y openssh-server

sudo ufw allow  20/tcp
sudo ufw allow  21/tcp
sudo ufw allow  22/tcp
sudo ufw allow  80/tcp

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
sudo systemctl restart ssh


sudo service apache2 restart

sudo systemctl start apache2

sudo mkdir /var/www/html/H1nts

wget http://192.168.153.1:8000/index.txt > /var/www/html/H1nts/index.html

wget http://192.168.153.1:8000/robots.txt > /var/www/html/robots.txt

sudo service apache2 reload


sudo mkdir -p /home/cooluser

sudo mkdir /home/cooluser/ftp

sudo chown nobody:nogroup /home/cooluser/ftp

sudo mkdir /home/cooluser/ftp/files
sudo chown cooluser:cooluser /home/cooluser/ftp/files

sudo systemctl enable vsftpd
sudo systemctl start vsftpd

echo "anon_root=/home/cooluser/ftp/files" >> /etc/vsftpd.conf
echo "hide_ids=YES" >> /etc/vsftpd.conf
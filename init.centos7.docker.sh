#!/bin/bash

yum -y update

groupadd -g 190 docker

echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel
chmod 0440 /etc/sudoers.d/wheel

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum -y install git vim-enhanced yum-utils device-mapper-persistent-data lvm2 htop wget fail2ban
systemctl enable fail2ban
systemctl start fail2ban
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce

curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

userdel -r centos

useradd -u 1808 -G wheel,docker saf
mkdir -m 0700 /home/saf/.ssh
touch /home/saf/.ssh/authorized_keys
chmod 0600 /home/saf/.ssh/authorized_keys
chown saf:saf /home/saf/.ssh /home/saf/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3eZXx/E24O4qrMBBAsZXKNw5V0VGY+6MiU4myxuYJW saf@mpbsaf" >> /home/saf/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF7UO/Hc1bE0IdjSVss7nUfvDMVr/r72I5yHrizMSiRSnyBMaPg8HTlpD6fD+7VLV/JuDJKOJ3DJVdyS/yXF5AhdY28YNqkccq+ToZC27CwUK86rPtmoQK3Ea7kq/42aMMmmlO3BzCld8V5gumg18bO7yAUAA1obuog0pkQ0+7S+lgqmT0TG0Pyto3oN5Tr1qcu7mpL0udq25aJVwsJiaeAAlbcjz47ZqsWxbKOEYyyI2S0UCu2/7DSAIWyBMaRBeyf9QBIg4HaqU8gfJ1bkdNQr/R/cH0mwg/ZWyjPflJRojL6ZiJYJQ5jBCF+90y6fJDSkMdOh6+/cPFOdFfv2i5 saf@mpbsaf" >> /home/saf/.ssh/authorized_keys


sudo -u saf -i git clone https://github.com/sumpfgottheit/dotfiles.git
su - saf -c "cd dotfiles && make"

cd /root
git clone https://github.com/sumpfgottheit/dotfiles.git
cd dotfiles
make


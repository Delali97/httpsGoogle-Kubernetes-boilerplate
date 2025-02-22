#!/bin/bash

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update

sudo apt install openjdk-11-jdk -y

sudo apt install jenkins -y

sudo systemctl start jenkins.service

sudo ufw allow OpenSSH
sudo ufw enable

sudo ufw allow 8080 -y

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo 'use the above code to unlock jenkins'

sudo ufw allow 8080 -y



echo 'Starting Docker Installation'
#!/bin/bash

# update apt
sudo apt-get update -y

#
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#
sudo mkdir -p /etc/apt/keyrings

#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#
sudo apt-get update -y

#
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#
sudo docker --version

#
sudo groupadd docker

#
sudo usermod -aG docker ${USER}

#
sudo systemctl restart docker

#
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#
sudo chmod +x /usr/local/bin/docker-compose

#
docker-compose --version

#optional
sudo apt install net-tools -y

#activate changes on group
newgrp docker

#!/bin/bash
sudo apt-get update -y
# Install OpenJDK 8
sudo apt-get install openjdk-8-jdk -y
# Install Jenkins
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install jenkins -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
#apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu
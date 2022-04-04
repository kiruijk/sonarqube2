#!/bin/bash

#Description: This script automates the installation of SonarQube
#Author: James K
#Date: 04/02/2022

#Checking that user is a regular user
echo "Checking if user is a regular user...."
sleep 2
if 
[ $UID -eq 0 ]
then
echo "Installation cannot proceed because user is root, please login as a regular user!"
sleep 2
exit 1
fi

echo "Installing Java 11....."
sleep 2
sudo yum update -y
sudo yum install java-11-openjdk-devel -y 
sudo yum install java-11-openjdk -y

if
[ $? -ne 0 ]
then
echo "Installation of Java 11 failed...."
sleep 2
exit 2
fi

echo "Downloading latest version of SonarQube...."
sleep 2
cd /opt 
sudo yum install wget -y 
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip

if
[ $? -ne 0 ]
then
echo "Latest version of SonarQube failed to download...."
sleep 2
exit 3
fi

echo "Extracting packages...."
sleep 2
sudo yum install unzip -y
sudo unzip /opt/sonarqube-9.3.0.51899.zip

if
[ $? -ne 0 ]
then
echo "Failed to extract packages..."
sleep 2
exit 4
fi

echo "Changing ownership to user and switching to linux binaries directory to start service...."
sleep 2
sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64
./sonar.sh start

if
[ $? -ne 0 ]
then
echo "Failed to change ownership to user and switch to linux binaries directory to start service.."
sleep 2
exit 5
fi

#Checking IP address
IP=`hostname -I |awk '{print$2}'`
echo "This is your IP address:${IP}"
sleep 2
echo "Type the folling into your brower: ${IP}:9000"

#!/bin/bash
# Set variables

BUCKET_NAME="upgrad-navneet"

sudo apt update
sudo apt install awscli
sudo apt update -y

sudo systemctl status apache2


if ! dpkg -s apache2 &> /dev/null; then
    sudo apt install apache2 -y
fi

if ! systemctl is-active --quiet apache2; then
    sudo systemctl start apache2
fi

if ! systemctl is-enabled --quiet apache2; then
    sudo systemctl enable apache2
fi


timestamp=$(date '+%d%m%Y-%H%M%S')
sudo tar -cvf /tmp/Navneet-httpd-logs-$timestamp.tar /var/log/apache2/*.log

aws s3 cp /tmp/Navneet-httpd-logs-$timestamp.tar s3://upgrad-navneet/

chmod  +x  /root/Automation_Project/automation.sh
sudo  su
./root/Automation_Project/automation.sh



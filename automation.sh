#!/bin/bash
# Set variables


chmod  +x  /root/Automation_Project/automation.sh
sudo  su
./root/Automation_Project/automation.sh

sudo apt update
sudo apt install awscli
sudo apt update -y



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
archive_name=$(echo "Navneet-httpd-logs-$timestamp.tar")

sudo tar -czf "/tmp/$archive_name" -C /var/log/apache2/ --exclude='*.gz' --exclude='*.zip' --exclude='*.tar' '*.log'

aws s3 cp "/tmp/$archive_name" "s3://upgrad-navneet"


BUCKET_NAME="upgrad-navneet"
ARCHIVE_NAME="your-archive-name"
ARCHIVE_PATH="path/to/your/archive"

# Run AWS CLI command to upload archive to S3 bucket
aws s3 cp $ARCHIVE_PATH s3://$BUCKET_NAME/$ARCHIVE_NAME
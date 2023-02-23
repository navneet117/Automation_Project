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


if [ ! -f /var/www/html/inventory.html ]; then
  
    echo "Log Type         Time Created         Type        Size" > /var/www/html/inventory.html
fi

echo "httpd-logs        $timestamp         tar        $size" >> /var/www/html/inventory.html



GIT_REPO_NAME="Automation_Project"
AUTOMATION_SCRIPT_PATH="/root/navneet117/Automation_Project/automation.sh"
CRON_JOB_NAME="automation"
CRON_JOB_SCHEDULE="0 0 * * *"
CRON_JOB_FILE="/etc/cron.d/${CRON_JOB_NAME}"

# Check if the cron job file already exists
if [[ -f "${CRON_JOB_FILE}" ]]; then
  echo "Cron job file already exists: ${CRON_JOB_FILE}"
  exit 0
fi

# Create the cron job file
echo "${CRON_JOB_SCHEDULE} root ${AUTOMATION_SCRIPT_PATH}" > "${CRON_JOB_FILE}"
echo "Cron job created: ${CRON_JOB_FILE}"

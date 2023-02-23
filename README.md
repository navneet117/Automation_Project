Perform an update of the package details and the package list at the start of the script.
Install the apache2 package if it is not already installed. (The dpkg and apt commands are used to check the installation of the packages.)
Ensure that the apache2 service is running. 
Ensure that the apache2 service is enabled. 
Create a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and place the tar into the /tmp/ directory. Create a tar of only the .log files.
The script should run the AWS CLI command and copy the archive to the s3 bucket. 

#!/bin/bash

#------- Task 2 Starting -------#
# 1 - Perform an update of the package details and the package list at the start of the script.
#Updating the packages
apt update -y

#Initializing variables
myname='vishal'
s3_bucket='upgrad-vishal'
timestamp=$(date '+%d%m%Y-%H%M%S')


# 2 - Install the apache2 package if it is not already installed. (The dpkg and apt commands are used to check the installation of the packages.)

if [ $(dpkg --list | grep apache2 | cut -d ' ' -f 3 | head -1) == 'apache2' ]
then
	# 4 - Ensure that the apache2 service is enabled.
	if [[ $(systemctl status apache2 | grep disabled | cut -d ';' -f 2) == ' disabled' ]];
		then
			systemctl enable apache2
			echo "Apache server is enabled"
			systemctl start apache2

# 3 - Ensure that the apache2 service is running. If not start it and make it active.	
		else
			if [ $(systemctl status apache2 | grep active | cut -d ':' -f 2 | cut -d ' ' -f 2) == 'active' ]
			then
				echo "Apache server is already running"
			else
				systemctl start apache2
				echo "Apache server is started"
			fi
	fi
# 2 - Install the apache2 package if it is not already installed. 
else
	printf 'Y\n' | apt-get install apache2
	echo "Apache server is installed"
	
fi

# 5 - Create a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and place the tar into the /tmp/ directory.

tar -zvcf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log


# 6 - The script should run the AWS CLI command and copy the archive to the s3 bucket. 

aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar



#------- Task 2 Ends -------#

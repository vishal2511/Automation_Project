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

#------- Task 3 Starting -------#

# 1 - Bookkeeping - Ensure that your script checks for the presence of the inventory.html file in /var/www/html/; if not found, creates it.

if [ -f "/var/www/html/inventory.html" ]; 
then
	
	printf "<p>" >> /var/www/html/inventory.html
	printf "\n\t$(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 2,3 | tail -1)" >> /var/www/html/inventory.html
	printf "\t\t$(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 4,5 | cut -d '.' -f 1 | tail -1)" >> /var/www/html/inventory.html
	printf "\t\t\t $(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 4,5 | cut -d '.' -f 2 | tail -1 )" >> /var/www/html/inventory.html
	printf "\t\t\t\t$(ls -lrth /tmp/ | grep httpd | cut -d ' ' -f 6 | tail -1)" >> /var/www/html/inventory.html
	printf "</p>" >> /var/www/html/inventory.html
	
else 
# 1 - Bookkeeping - If an inventory file already exists, the content of the file should not be deleted or overwritten. New content should be only appended in a new line.
	touch /var/www/html/inventory.html
	printf "<p>" >> /var/www/html/inventory.html
	printf "\tLog-Type\tDate-Created\tType\tSize" >> /var/www/html/inventory.html
	printf "</p>" >> /var/www/html/inventory.html
	printf "<p>" >> /var/www/html/inventory.html
	printf "\n\t$(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 2,3 | tail -1)" >> /var/www/html/inventory.html
	printf "\t\t$(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 4,5 | cut -d '.' -f 1 | tail -1)" >> /var/www/html/inventory.html
	printf "\t\t\t $(ls -lrth /tmp | grep httpd | cut -d ' ' -f 10 | cut -d '-' -f 4,5 | cut -d '.' -f 2 | tail -1)" >> /var/www/html/inventory.html
	printf "\t\t\t\t$(ls -lrth /tmp/ | grep httpd | cut -d ' ' -f 6 |tail -1)" >> /var/www/html/inventory.html
	printf "</p>" >> /var/www/html/inventory.html
	
fi


# 2 - Cron Job - Your script should create a cron job file in /etc/cron.d/ with the name 'automation' that runs the script /root/<git repository name>/automation.sh every day via the root user.

if [ -f "/etc/cron.d/automation" ];
then
	echo "Automation script is present in /etc/cron.d/"
else
	touch /etc/cron.d/automation
	printf "0 0 * * * root /root/Automation_Project/auotmation.sh" > /etc/cron.d/automation
fi

#------- Task 3 Ends -------#

# Automation_Project
This project consists of three Tasks-

**Task 1:** AWS services - Setup necessary infrastructure on AWS 
To Create an IAM role, a security group, an S3 bucket and launch an EC2 instance.
EC2 will be a WebServer with Apache2 server installed and launched. 
S3 bucket is used for storing the WebServer logs. 

**Task 2:** Linux, scripting, web servers and Git -	Write a Bash script to automate the installation of a web server (Any packages in general) on a Linux machine and host the code on GitHub with the appropriate tag.
Once the virtual machine (VM) is set up, We have to create an automation script named ‘automation.sh’ to configure the Virtual Machine (web server) for hosting a web server and later automating some maintainance tasks. 
We have to ensure that the apache2 server is running and it restarts automatically in case the EC2 instance reboots.
We have to create a backup of Apache2 server logs by compressing the logs directory and archiving it to the s3 bucket (Storage).
‘automation.sh’ needs to be placed in '/root/Automation_Project/' directory.
We also needs to initialise a Git repository with the name ‘Automation_Project’ and commit the script into it. 
We have to create a tag named Automation-v0.1  

**Task 3:** DevOps  (Automation) - Automate Daily routine tasks using a script. (Cron jobs and text manipulation)
There are two significant areas of improvement in our previous script.
1. Script will create a record when the tar file is copied from the EC2 to s3 in /var/www/html/inventory.html.
2. Script itself will set a cron job that will run the script at a regular interval of time.
We have to create a tag named Automation-v0.2  

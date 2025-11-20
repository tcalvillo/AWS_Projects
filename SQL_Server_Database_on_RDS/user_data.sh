#!/bin/bash
# Update the system
yum update -y

# Install necessary packages
yum install -y httpd

# Start the Apache web server
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page
echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html

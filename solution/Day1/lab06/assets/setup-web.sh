#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable  apache2
echo "<html><h1>Welcome to Aapache Web Server</h2></html>" > /var/www/html/index.html

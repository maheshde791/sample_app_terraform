#!/bin/bash
sudo apt-get update -y
apt-get install apache2 -y
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
chmod 644 /var/www/html/index.html
systemctl enable apache2
systemctl start apache2

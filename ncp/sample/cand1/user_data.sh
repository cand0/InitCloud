#!/bin/bash

apt-get install -y apache2
echo "NCP SERVER-$HOSTNAME" > /var/www/html/index.html
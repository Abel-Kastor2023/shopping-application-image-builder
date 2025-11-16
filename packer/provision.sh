#!/bin/bash

yum install httpd php -y

systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service

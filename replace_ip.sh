#!/bin/bash

ip=$(cat ./ec2_public_ip)
sed -i "2s/.*/ubuntu@$ip/" ansible/inventory 

cp ./jenkins.pem ./secret.pem
chmod 700 ./secret.pem


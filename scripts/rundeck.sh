#! /bin/bash

# Update the repository
yum -y update
# Install java 8
yum install java-1.8.0 -y
# Install Rundeck: https://docs.rundeck.com/docs/administration/install/linux-rpm.html#installing-rundeck
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | sudo bash -s rundeck
yum install rundeck -y && yum update rundeck
service rundeckd start

#!/bin/bash
#List All Postgres related packages
dpkg -l | grep postgres

#remove all above listed
apt-get --purge remove postgresql-10 postgresql-client-10 postgresql-common postgresql-client-common

#unistall user postgres
userdel - r postgres

#Remove the following folders

sudo rm -rf /var/lib/postgresql/
sudo rm -rf /var/log/postgresql/
sudo rm -rf /etc/postgresql/




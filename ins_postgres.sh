#!/bin/bash
#install postgres from source
wget http://repo.postgrespro.ru/pgpro-11/src/postgrespro-standard-11.1.1.tar.bz2 /home/akatruk/Downloads/

#add utilities
apt-get install gcc libreadline-dev bzip2 zlib1g-dev make

#unpacked file
cd /home/akatruk/Downloads/
tar xvjf postgrespro-standard-11.1.1.tar.bz2
rm -rf /home/akatruk/Downloads/postgrespro-standard-11.1.1.tar.bz2

#create user postgres
useradd -m -d /home/postgres postgres

#create directory for distributive
rm -rf /u01/psql/
mkdir -r /u01/psql/
chown postgres /u01/psql/
chmod 777 /u01/psql/

#prepare instalation postgres
cd /home/akatruk/Downloads/postgrespro-standard-11.1.1/
./configure -prefix /u01/pgsql

#install postgres
cd /u01/psql/
make install

#remove installation distributive
rm -rf /home/akatruk/Downloads/postgres/

#create catalog for database
mkdir -p /u02/
chown postgres /u02
chmod 777 /u02


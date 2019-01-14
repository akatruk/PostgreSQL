#!/bin/bash
#install postgres from source
wget http://repo.postgrespro.ru/pgpro-11/src/postgrespro-standard-11.1.1.tar.bz2 /home/akatruk/Downloads/

#unpacked file
rmdir /home/akatruk/Downloads/distr_postgres/
mkdir /home/akatruk/Downloads/distr_postgres/
chmod 777 /home/akatruk/Downloads/distr_postgres/
cd /home/akatruk/Downloads/
tar xvjf postgrespro-standard-11.1.1.tar.bz2 /home/akatruk/Downloads/distr_postgres/
rm -rf /home/akatruk/Downloads/postgrespro-standard-11.1.1.tar.bz2

#create directory for distributive
rmdir -r /u01/psql/
mkdir -r /u01/psql/

#prepare instalation postgres
cd /home/akatruk/Downloads/
./configure -prefix /u01/pgsql

#add utilities
apt-get install gcc libreadline-dev

#install postgres
cd /u01/psql/
make install

#remove installation distributive
rm -rf /home/akatruk/Downloads/postgres/


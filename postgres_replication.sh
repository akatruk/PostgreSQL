# replication
# One server

1. Install postgres
2. backup postgres
pg_basebackup -U postgres --pgdata=/var/lib/pgsql/test2 -R --slot=replica
3. Add in config file 
echo 'port = 5433' >> /var/lib/pgsql/test2/postgresql.auto.conf
echo 'hot_standby = on' >> /var/lib/pgsql/test2/postgresql.auto.conf


# replication
# Two servers

1. Install and configure postgres on first node/just install postgresql on second node
2. Open 5432 posts on both servers

firewall-cmd --permanent --add-port=5432/tcp
firewall-cmd --reload

3. Creat a slot for replica on master
SELECT pg_create_physical_replication_slot('replica');

4. pg_hba.conf
host    replication     all 192.168.56.0/24 trust

5. postgresql.conf on master
listen_addresses = '*'
or 
echo 'listen_addresses = '*'' >> /var/lib/pgsql/test/project/data/postgresql.conf 

6. Run command on slave node
pg_basebackup -h 192.168.56.101 -D /var/lib/pgsql/test/project/data -R --slot=replica

7. postgresql.conf on slave
echo 'hot_standby = on' >> /var/lib/pgsql/test/project/data/postgresql.auto.conf

### Failover replication postgresql
/usr/pgsql-11/bin/pg_ctl promote -D /var/lib/pgsql/test2/

### Configure replica to back after failover (PG_REWIND)
1. Create replication slot on failed server
SELECT pg_create_physical_replication_slot('replica');

2. Make password on postgres user in database
ALTER USER postgres PASSWORD 'Vfhnvfhn123';
3. Add on target server 
echo "wal_log_hints = on" >> /var/lib/pgsql/test/project/data/postgresql.auto.conf
4. Execut command
/usr/pgsql-11/bin/pg_rewind -D /var/lib/pgsql/test/project/data/ --source-server="host=192.168.56.102 port=5432 user=postgres password=Vfhnvfhn123" -P
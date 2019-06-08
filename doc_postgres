###vacuum###

Check if autovacuum was configured 
SELECT name, setting FROM pg_settings WHERE name='autovacuum';
#At 9.6 version autovacuum was configured autamaticaly.

---

PostgreSQL VACUUM metrics to monitor

1. Counts of dead rows
SELECT relname, n_dead_tup FROM pg_stat_user_tables;

2. Table disk usage
Tracking the amount of disk space used
#The querys you the table that is using the most disk space in DB
SELECT 
       relname AS "table_name", 
       pg_size_pretty(pg_table_size(C.oid)) AS "table_size" 
FROM 
       pg_class C 
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace) 
WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND nspname !~ '^pg_toast' AND relkind IN ('r') 
ORDER BY pg_table_size(C.oid) 
DESC LIMIT 1;

3. The last time a autovacuum was run
SELECT relname, last_vacuum, last_autovacuum FROM pg_stat_user_tables;

4. Manual/nightly vacuum events ???

!!!5. Monitoring free size in table space
1. Create extension pgstattuple;

2. Get report about useful of vacuum
SELECT * FROM pgstattuple('pg_catalog.pg_proc');

https://postgrespro.ru/docs/postgrespro/9.5/pgstattuple

Notes:
https://www.datadoghq.com/blog/postgresql-vacuum-monitoring/

---

Check if autvacuum is runninng 
ps -axww | grep autovacuum

---

How to monitor a process of vacuum or\if transaction of vacuum?

---------

###Shared Buffer###
How to monitor of effectivity a buffer manager?
Best practice configuring buffer manager?

configure '25%' from all server RAM also need to configure max_wal_size

Is need extend pg_buffercache?

1. Add extension
CREATE EXTENSION pg_buffercache;

2. monitoring Buffer

SELECT c.relname, count(*) AS buffers
             FROM pg_buffercache b INNER JOIN pg_class c
             ON b.relfilenode = pg_relation_filenode(c.oid) AND
                b.reldatabase IN (0, (SELECT oid FROM pg_database
                                      WHERE datname = current_database()))
             GROUP BY c.relname
             ORDER BY 2 DESC
             LIMIT 10;
What is differents between boot_wal and reset_wal?

---

###Locks###
https://habr.com/ru/post/319832/

---
pgbouncer ???
pgbadger ???
pgpool ???

---

###Settings postgresql###
Is it possible reload server setting without stoping server?
How to work reload commands?
select pg_reload_conf();
pg_ctl reload

For what need postgresql.auto.conf? question for DBI
How to configure postgresql.auto.conf?
ALTER SYSTEM
RESET conf_parameter | ALL;
For what need pg_setting.context?
internal, postmaster, singup, backend, superuser, user?

postgres=# show conf_parameter;
ERROR:  unrecognized configuration parameter "conf_parameter"
pg_db_role_setting

How to configure work_mem?


Beging
listen_address
max_connections
work_mem
maintenance_work_mem
shared_buffers
effective_cache_size

---

###Maintance database###
pg_repack?
Monitorung index
pg_stat_all_indexes
pg_relation_size()

---

###Monitoring database###
pg_stat_statements Статистика по запросам
pg_stat_plans Статистика плана запроса
pg_stat_kcache Статистика по I/O
pg_qualstats Статистика по предикатам
pg_pg_stat_activity Все процессы
pg_stat_all_tables Статистика по всем таблицам
pg_stat_database Статистика по БД

Study extended log file !!!
1. Enable extended logs
alter system set log_prefix = '!!! pid=%p: ';
alter system set log_duration= 'on';
alter system set log_statement='all';
pg_ctl reload

2. Run test command
select sum(random)) from generate_series(1,10000000);

3. Grep log file
grep ^!!! -postgres/logfile | tail -n 2

---

###Backups###
copy to file 
db01=# copy t1 to /home/akatruk/out1;
ERROR:  syntax error at or near "/"
LINE 1: copy t1 to /home/akatruk/out1;


pg_dump - utility for backup DB
--data-only DML
--schema-only DDL 
Example: pg_dump -d [DB_name] -f [dump_path]

Restore database psql -d db01 -f /u01/db01

pg_restore - utility for restore DB
--clean Delete objects from database
--create In advance it create DB
Example: pg_restore -d db [DB_name] -f [dump_path]  
What is object ID/OID?

---
###Replications in PostgreSQL###
PostgreSQL BDR???
каскадная репликация???
statement-based репликация???
Репликация обратной связи???
Restoring master server pg_rewind???
pg_logical, pg_driver replication master-master???
Second Quadrant

---
###Replications in MS SQL###
How to work MS SQL Always ON?
How to work MS SQL Replications?

###Troubleshuting###
###External tools###
Top (procps)
iostat (sysstat), iotop
nicstat
pgcenter
perf

###Internal views###
!!! Запрос Лаг репликации pg_wal_lsn_diff and pg_stat_replication
https://shiningapples.net/postgresql-%D1%83%D0%B7%D0%BD%D0%B0%D1%82%D1%8C-replication-lag/
pg_stat_replication, pg_stat_wal_receiver
pg_stat_databases. pg_stat_databases_conflicts
pg_stat_activity
pg_stat_archiver

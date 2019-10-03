-- size specific of schema
select schemaname ,round(sum(pg_total_relation_size(schemaname||'.'||tablename))/1024/1024/1024) "Size_GB" from pg_tables where schemaname='rms_p009qtzb_rms_ods' group by 1;

-- database size
select pg_size_pretty(pg_database_size('DATBASE_NAME'));

-- size specific of table 

-- free size for database
select pg_size_pretty(pg_total_relation_size('schema.tablename'));   

-- Available disk space in Greenplum
SELECT sodddatname, (sodddatsize/1073741824) AS sizeinGB FROM gp_toolkit.gp_size_of_database;

backup 
https://gpdb.docs.pivotal.io/43280/utility_guide/admin_utilities/gpbackup.html

-- backup schema 
gpbackup --dbname demo --include-schema twitter --backup-dir /home/gpadmin/backup

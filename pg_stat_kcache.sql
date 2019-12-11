SELECT datname, queryid, round(total_time::numeric, 2) AS total_time, calls,
 pg_size_pretty((shared_blks_hit+shared_blks_read)*8192 - reads) AS memory_hit,
 pg_size_pretty(reads) AS disk_read, pg_size_pretty(writes) AS disk_write,
 round(user_time::numeric, 2) AS user_time, round(system_time::numeric, 2) AS
system_time
FROM pg_stat_statements s
 JOIN pg_stat_kcache() k USING (userid, dbid, queryid)
 JOIN pg_database d ON s.dbid = d.oid
WHERE datname != 'postgres' AND datname NOT LIKE 'template%'
ORDER BY total_time DESC LIMIT 10;
18
SELECT datname, queryid, round(total_time::numeric, 2) AS total_time, calls,
 pg_size_pretty((shared_blks_hit+shared_blks_read)*8192 - reads) AS memory_hit,
 pg_size_pretty(reads) AS disk_read, pg_size_pretty(writes) AS disk_write,
 round(user_time::numeric, 2) AS user_time, round(system_time::numeric, 2) AS
system_time
FROM pg_stat_statements s
 JOIN pg_stat_kcache() k USING (userid, dbid, queryid)
 JOIN pg_database d ON s.dbid = d.oid
WHERE datname != 'postgres' AND datname NOT LIKE 'template%'
ORDER BY total_time DESC LIMIT 10;

create extension pg_stat_kcache

https://m.habr.com/ru/company/pgdayrussia/blog/329178/
https://github.com/powa-team/pg_stat_kcache


Начиная с 9.4, появилась отличная штука, которая называется pg_stat_kcache, 
которая позволяет посмотреть с точностью до запроса, в том числе потребление процессора в юзертайме, 
потребление процессора в системтайме. И очень крутая штука, которую она умеет – это разделение физических чтений с диска и 
получение данных page cache из операционной системы.

Но это не самое большое преимущество pg_stat_kcache. 
Можно сортировать по чтениям с диска, по записи на диск, и т.д. 
Например, тот же самый pg_stat_statements умеет разделять shared_hit и shared_read. Это значит чтение из разделяемой памяти
 (shared buffers) и все остальное. И это все остальное может быть из page cache операционной системы, а может быть физически с диска. 
 pg_stat_kcache их умеет разделять. Делает он это с помощью системного вызова getrusage(), который дёргается после каждого запроса.


instalation 
git clone https://github.com/powa-team/pg_stat_kcache.git
cd pg_stat_kcache
make
make install
# postgresql.conf
shared_preload_libraries = 'pg_stat_statements,pg_stat_kcache'
mydb=# CREATE EXTENSION pg_stat_kcache;

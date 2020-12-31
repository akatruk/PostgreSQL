
-- top read/writh table
SELECT
	schemaname||'.'||relname,
	n_live_tup,
	seq_scan,
	seq_tup_read,
	(coalesce(n_tup_ins,0)+coalesce(n_tup_upd,0)+coalesce(n_tup_del,0)) as write_activity,
	(SELECT count(*) FROM pg_index WHERE pg_index.indrelid=pg_stat_all_tables.relid) AS index_count,
	idx_scan,
	idx_tup_fetch
FROM pg_stat_all_tables
WHERE
	seq_scan>0
	AND seq_tup_read>100000
	AND schemaname<>'pg_catalog'
ORDER BY
	seq_tup_read DESC
LIMIT 20;

-- get size all tables
SELECT
  schema_name,
  relname,
  pg_size_pretty(table_size) AS size,
  table_size
FROM (
       SELECT
         pg_catalog.pg_namespace.nspname           AS schema_name,
         relname,
         pg_relation_size(pg_catalog.pg_class.oid) AS table_size
       FROM pg_catalog.pg_class
         JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
     ) t
WHERE schema_name NOT LIKE 'pg_%'
ORDER BY table_size DESC;
https://habr.com/ru/post/13992/

-- Index stat
SELECT 
      indexrelname, 
      idx_tup_read, 
      idx_tup_fetch, 
      CASE 
        WHEN idx_tup_fetch = 0 THEN 100 
        ELSE idx_tup_read / idx_tup_fetch 
      END AS ratio 
    FROM 
      pg_stat_user_indexes 
    ORDER BY 
      ratio DESC;

-- Table that is using the most disk space in your database
SELECT 
       relname AS "table_name", 
       pg_size_pretty(pg_table_size(C.oid)) AS "table_size" 
FROM 
       pg_class C 
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace) 
WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND nspname !~ '^pg_toast' AND relkind IN ('r') 
ORDER BY pg_table_size(C.oid) 
DESC LIMIT 1;


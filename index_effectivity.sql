SELECT
    idstat.relname    				        AS table_name,                  -- имя таблицы
    indexrelname    				        AS index_name,                  -- индекс
    idstat.idx_scan    			                AS index_scans_count,           -- число сканирований по этому индексу
    pg_size_pretty(pg_relation_size(indexrelid))        AS index_size,                  -- размер индекса
    tabstat.idx_scan    			        AS table_reads_index_count,     -- индексных чтений по таблице
    tabstat.seq_scan    			        AS table_reads_seq_count,       -- последовательных чтений по таблице
    tabstat.seq_scan + tabstat.idx_scan    	        AS table_reads_count,           -- чтений по таблице
    n_tup_upd + n_tup_ins + n_tup_del    	        AS table_writes_count,          -- операций записи
    pg_size_pretty(pg_relation_size(idstat.relid))      AS table_size                   -- размер таблицы
FROM
    pg_stat_user_indexes    			        AS idstat
JOIN
    pg_indexes
    ON
    indexrelname = indexname
    AND
    idstat.schemaname = pg_indexes.schemaname
JOIN
    pg_stat_user_tables    			        AS tabstat
    ON
    idstat.relid = tabstat.relid
WHERE
    indexdef !~* 'unique'
ORDER BY
    idstat.idx_scan DESC,
    pg_relation_size(indexrelid) DESC;


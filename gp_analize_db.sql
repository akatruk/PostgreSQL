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


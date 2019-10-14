SELECT nk, op_type, op_ts, pos, h, dt_created, is_init
FROM cvm_p_tpcvm_db_tpenterprise_raw.tmp_cvmjournal limit 10;


CREATE TABLE public.test_compression AS 
SELECT
*
FROM
    cvm_p_tpcvm_db_tpenterprise_raw.tmp_cvmjournal;

   
   select * from public.test_compression limit 10;
   
SELECT sotdschemaname as SCHEMA, sotdtablename,(sotdsize/1073741824) as tableGB 
FROM gp_toolkit.gp_size_of_table_disk 
WHERE sotdschemaname = 'public' 
AND (sotdsize/1073741824) > 0 
ORDER BY sotdtablename;


SELECT pg_size_pretty(pg_relation_size('public.test_compression'));

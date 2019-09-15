https://community.pivotal.io/s/article/Identify-Tables-that-Need-Vacuum-Analyze

-- check tables on bloat
SELECT * FROM gp_toolkit.gp_bloat_diag;

-- 

LOCK TABLE mytable IN EXCLUSIVE MODE;
CREATE TABLE account_tmp AS SELECT * FROM account;
DROP TABLE mytable;
ALTER TABLE mytabe_tmp RENAME TO mytable;



ALTER TABLE d_dacc_guaranteed_stock.gs_dm SET WITH (REORGANIZE=false) 
DISTRIBUTED randomly;
ALTER TABLE d_dacc_guaranteed_stock.gs_dm SET WITH (REORGANIZE=true) 
DISTRIBUTED BY (report_date);
vacuum d_dacc_guaranteed_stock.gs_dm;

alter table metadata.tbl_scd4_tbl_key_list SET WITH (REORGANIZE=true);

SELECT pg_size_pretty(pg_table_size('d_dacc_guaranteed_stock.gs_dm'));

psql adb -t -A -F"," -c 'vacuum verbose sandbox_logistics.wms_kuf_908_getoue' &> vacuum verbose sandbox_logistics.wms_kuf_908_getoue.txt
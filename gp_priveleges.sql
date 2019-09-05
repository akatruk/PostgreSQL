## How to grant privilege
create role team_ga nologin;
create role "60076294" login;         
grant team_ga to "60076294"; 
grant select on td_idwh1_bv_prod_009_pbsdbs_ods to team_rms;
grant select on rms_p009qtzb_rms_ods.item_master to team_ga;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA rms_p009qtzb_rms_ods FROM team_rms;


## Granted privilege
SELECT table_catalog, table_schema, table_name, privilege_type
FROM   information_schema.table_privileges 
WHERE  grantee = 'team_ga';

## Find objects in database

## Find specific schema
SELECT nspname FROM pg_catalog.pg_namespace order by nspname where nspname like '%rms%';

## List all tables in specific schema
SELECT table_name FROM information_schema.tables WHERE table_schema='rms_p009qtzb_rms_raw';

SELECT table_name FROM information_schema.tables 
WHERE table_schema='td_idwh1_bv_prod_009_pbsdbs_ods'
and table_name like 'tf009_vte_ligticcai';

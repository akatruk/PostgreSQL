-- Grant privilege
create role team_rms nologin;
create role "60065275" login;         
grant team_rms to "akatruk"; 
grant ldap_users to "akatruk"; 
grant select on td_idwh1_bv_prod_009_pbsdbs_raw to team_rms;
grant select on rms_p009qtzb_rms_ods.item_master to team_ga;
-- Grant privilege on schema
GRANT USAGE ON SCHEMA metadata TO team_rms;

-- Drop user
DROP USER team_rms;
REVOKE ALL PRIVILEGES ON SCHEMA rms_p009qtzb_rms_raw FROM team_rms;

-- Granted privilege
SELECT table_catalog, table_schema, table_name, privilege_type FROM information_schema.table_privileges WHERE  grantee = 'team_rms';

----------------------------------------
-- Find objects in database --
-- Find specific schema
SELECT nspname 
FROM pg_catalog.pg_namespace 
WHERE nspname like '%metadata%';

-- List all tables in specific schema
SELECT table_name FROM information_schema.tables WHERE table_schema='rms_p009qtzb_rms_raw';

-- List privelege on user
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee::text in (select  unnest(rolname||
  ARRAY(SELECT b.rolname
        FROM pg_catalog.pg_auth_members m
        JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
        WHERE m.member = r.oid))::text
FROM pg_catalog.pg_roles r
WHERE r.rolname ='team_rms');

GRANT CREATE TABLE TO rms_p009qtzb_rms_raw TO 'rms_p009qtzb_rms_raw';

-- 
do
$$
declare 
	var_role_name text;
	var_table_name text;
	var_query_sql text;

begin	
	var_role_name = '"team_rms"';
	
	for var_table_name in   	
		select
			table_schema||'.'||table_name
		from
			information_schema.tables
		where
			table_schema like 'metadata%'
	
	loop
		var_query_sql = 'grant select on ' ||var_table_name ||' to ' || var_role_name||';';
	    
		begin
	        execute var_query_sql;
	        exception
	        when others then
	            raise notice 'Error skip table, %, %',var_table_name, sqlerrm;
	    end;
	   
	        raise notice '%', var_query_sql;
	end loop;
end;
$$
language 'plpgsql';
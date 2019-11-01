
------------- 1. select each 5 min row  -----------------------------------------

drop table if exists temp_a;
create table temp_a (like queries_history);
insert into temp_a 
select ctime, tmid, ssid, ccnt, username, db, cost, tsubmit, tstart, tfinish, status, rows_out, cpu_elapsed, cpu_currpct, skew_cpu, skew_rows, query_hash, query_text, query_plan, application_name, rsqname, rqppriority
from queries_history as qh   
WHERE  ctime > now() - interval '5 minutes';
-- select *
-- from temp_a;

------------- 2. insert #temp ---------------------------------------------------

DO
$$
DECLARE
rec record;
BEGIN
FOR rec IN EXECUTE 'explain verbose select query_text from temp_a as qh ' 
LOOP
--  RAISE NOTICE 'rec=%', row_to_json(rec);

    insert into queries_history_cost (query_plan)
    select rec."QUERY PLAN";
END LOOP;

END
$$ language plpgsql;

------------- 3. explain cursor & insert into public.query_history_cost ---------

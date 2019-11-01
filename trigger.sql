
 
select * from queries_history_cost




CREATE OR REPLACE FUNCTION public.fx()
	RETURNS text
	LANGUAGE plpgsql
	VOLATILE
AS $$ 	
declare
    qstr text;
begin


 qstr := 'explain verbose select query_text from queries_history as qh limit 1' ;
 insert into   x      
execute 'explain verbose select query_text from queries_history as qh limit 1'  ;

    return qstr;
end;
 $$
;

select * from public.fx()
explain verbose select query_text from queries_history as qh limit 1

CREATE TABLE public.x (
	query_text text NULL

);



trancate 


ALTER TABLE queries_history_cost 
ALTER COLUMN query_plan_total text not null;


drop table if exists temp_a;
create temp table temp_a
(
    "QUERY PLAN" text
);


insert into queries_history_cost select ctime, tmid, ssid, ccnt, username, db, cost, tsubmit, tstart, 
tfinish, status, rows_out, cpu_elapsed, cpu_currpct, skew_cpu, skew_rows,	query_hash,	query_text,	query_plan,	application_name, rsqname, rqppriority
 from queries_history as qh   WHERE  ctime > now() - interval '5 minutes';

DO
$$
DECLARE
rec record;
BEGIN

FOR rec IN EXECUTE 'explain verbose select query_text from queries_history_cost as qh ' 
LOOP
--  RAISE NOTICE 'rec=%', row_to_json(rec);

    insert into queries_history_cost (query_plan_total)
    select rec."QUERY PLAN";
END LOOP;

END
$$ language plpgsql;





drop table if exists temp_a;
create temp table temp_a;
insert into temp_a 
select ctime, tmid, ssid, ccnt, username, db, cost, tsubmit, tstart, tfinish, status, rows_out, cpu_elapsed, cpu_currpct, skew_cpu, skew_rows, query_hash, query_text, query_plan, application_name, rsqname, rqppriority
from queries_history as qh   
WHERE  ctime > now() - interval '5 minutes';
select *
from temp_a;


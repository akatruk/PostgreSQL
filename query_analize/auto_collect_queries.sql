0 * * * * psql -h localhost -U postgres < query.sql > $(date +"%Y_%m_%d_%I_%M_%p").log

with CTE1 as
(select query, calls, (total_time/calls)::integer as avg_time_ms 
from pg_stat_statements
where calls > 1000
order by avg_time_ms desc)
select * from CTE1 
where avg_time_ms > 1000;
select pg_stat_statements_reset();
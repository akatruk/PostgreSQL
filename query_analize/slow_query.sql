with CTE1 as
(select query, calls, (total_time/calls)::integer as avg_time_ms 
from pg_stat_statements
where calls > 1000
order by avg_time_ms desc)
select * from CTE1 
where avg_time_ms > 1000



select query, calls, (total_time/calls)::integer as avg_time_ms 
from pg_stat_statements
where calls > 1000
order by avg_time_ms desc
limit 100;
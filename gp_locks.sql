SELECT * FROM pg_stat_activity where waiting = true and waiting_reason = 'lock';

--Drop all <IDLE> transactions
SELECT pg_terminate_backend(procpid) 
FROM pg_stat_activity 
WHERE current_query = '<IDLE> in transaction';

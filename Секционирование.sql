-- max_locks_per_transaction
-- n - count of sections
ALTER SYSTEM SET max_locks_per_transaction = 'n';
-- synchronous_commit
ALTER SYSTEM SET synchronous_commit = 'off';
-- synchronous_commit
ALTER SYSTEM SET partition_pruning = 'on';

 
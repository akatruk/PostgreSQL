-- Database size
SELECT pg_database_size(current_database());


-- Table size
SELECT relname, relpages FROM pg_class ORDER BY relpages DESC;

-- Connected users
SELECT datname,usename,client_addr,client_port FROM pg_stat_activity;

-- Activity of user
SELECT datname FROM pg_stat_activity WHERE usename = 'USER';
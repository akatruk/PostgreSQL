-- Create a temporary table to store results
drop table if exists  tmp_pgstattuple_results;
CREATE TEMP TABLE tmp_pgstattuple_results (
    schema_name TEXT,
    table_name TEXT,
    table_len BIGINT,
    tuple_count BIGINT,
    tuple_len BIGINT,
    tuple_percent FLOAT,
    dead_tuple_count BIGINT,
    dead_tuple_len BIGINT,
    dead_tuple_percent FLOAT,
    free_space BIGINT,
    free_percent FLOAT
);
DO $$
DECLARE
    tbl RECORD;
BEGIN
    FOR tbl IN
        SELECT schemaname, tablename
        FROM pg_tables
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        RAISE NOTICE 'Analyzing %.%', tbl.schemaname, tbl.tablename;
        EXECUTE format(
            'INSERT INTO tmp_pgstattuple_results
             SELECT %L, %L, * FROM pgstattuple(%L)',
             tbl.schemaname, tbl.tablename, format('%I.%I', tbl.schemaname, tbl.tablename)
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Return all results
SELECT * FROM tmp_pgstattuple_results ORDER BY dead_tuple_percent;

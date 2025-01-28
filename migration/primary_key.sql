-- primary_key must be on each table before migration

WITH tables_with_pk AS (
    SELECT
        c.oid AS table_oid,
        c.relname AS table_name,
        n.nspname AS schema_name,
        TRUE AS has_primary_key
    FROM
        pg_constraint con
    JOIN pg_class c ON con.conrelid = c.oid
    JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE
        con.contype = 'p'
),
all_tables AS (
    SELECT
        c.oid AS table_oid,
        c.relname AS table_name,
        n.nspname AS schema_name,
        FALSE AS has_primary_key
    FROM
        pg_class c
    JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE
        c.relkind = 'r'
        AND n.nspname NOT IN ('pg_catalog', 'information_schema')
)
SELECT
    at.schema_name,
    at.table_name,
    CASE
        WHEN tpk.has_primary_key THEN 'Yes'
        ELSE 'No'
    END AS has_primary_key
FROM
    all_tables at
LEFT JOIN
    tables_with_pk tpk ON at.table_oid = tpk.table_oid
ORDER BY
    at.schema_name,
    at.table_name;
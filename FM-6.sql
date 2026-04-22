-- ============================================================
-- Create file format for CSV files (if not already created)
-- Adjust FIELD_OPTIONALLY_ENCLOSED_BY and SKIP_HEADER as needed
-- ============================================================
CREATE OR REPLACE FILE FORMAT my_db.my_schema.ff_csv_standard
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('', 'NULL', 'null');

-- ============================================================
-- Create external/internal stage pointing to CSV location
-- Replace URL / STORAGE_INTEGRATION / CREDENTIALS as appropriate
-- ============================================================
CREATE OR REPLACE STAGE my_db.my_schema.stg_source_csv
    URL = 's3://my-bucket/path/to/csv/'
    STORAGE_INTEGRATION = my_s3_integration
    FILE_FORMAT = my_db.my_schema.ff_csv_standard;

-- ============================================================
-- Optional: Inspect sample file to validate structure
-- ============================================================
-- LIST @my_db.my_schema.stg_source_csv;
-- SELECT * FROM TABLE(
--     EXTERNAL_TABLE_INFER_SCHEMA(
--         LOCATION=>'@my_db.my_schema.stg_source_csv',
--         FILE_FORMAT=>'my_db.my_schema.ff_csv_standard'
--     )
-- );

-- ============================================================
-- Target table definition (example)
-- Adjust columns and data types per actual schema
-- ============================================================
CREATE OR REPLACE TABLE my_db.my_schema.target_table (
    id              NUMBER(38,0),
    name            VARCHAR(255),
    created_at      TIMESTAMP_NTZ,
    is_active       BOOLEAN,
    amount          NUMBER(18,2)
);

-- ============================================================
-- COPY command to load CSV data into target table
-- Best practices:
--   - Use ON_ERROR for controlled failure behavior
--   - Use VALIDATION_MODE in dry runs before production loads
--   - TRUNCATECOLUMNS to avoid failures on minor length issues
-- ============================================================
COPY INTO my_db.my_schema.target_table
FROM (
    -- CTE-like inline SELECT allows transformations if needed
    SELECT
        $1::NUMBER(38,0)        AS id,
        $2::VARCHAR(255)        AS name,
        $3::TIMESTAMP_NTZ       AS created_at,
        $4::BOOLEAN             AS is_active,
        $5::NUMBER(18,2)        AS amount
    FROM @my_db.my_schema.stg_source_csv
)
FILE_FORMAT = (FORMAT_NAME = my_db.my_schema.ff_csv_standard)
ON_ERROR = 'ABORT_STATEMENT'
TRUNCATECOLUMNS = TRUE
PURGE = FALSE;
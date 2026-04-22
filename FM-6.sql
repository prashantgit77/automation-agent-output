-- ====================================================================================
-- Snowflake COPY Command Script: Load CSV Data into Target Table
-- ====================================================================================

-- Assumes:
--   1) Target table already exists (replace with your database/schema/table).
--   2) External/internal stage already exists (replace stage name and path).
--   3) CSV file is comma-delimited with header row.
--   4) File encoding is UTF-8 and newline is \n.
-- ====================================================================================

-- Optional: Set context (uncomment and adjust as needed)
-- USE ROLE      YOUR_ROLE_NAME;
-- USE WAREHOUSE YOUR_WAREHOUSE_NAME;
-- USE DATABASE  YOUR_DATABASE_NAME;
-- USE SCHEMA    YOUR_SCHEMA_NAME;

-- ====================================================================================
-- Define/Use File Format for CSV
-- ====================================================================================
-- Best practice: use a named file format so COPY command is concise and reusable.

CREATE OR REPLACE FILE FORMAT YOUR_DATABASE_NAME.YOUR_SCHEMA_NAME.FF_CSV_STANDARD
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('', 'NULL', 'null')
    EMPTY_FIELD_AS_NULL = TRUE
    COMPRESSION = 'AUTO'
    ENCODING = 'UTF8'
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
    TRIM_SPACE = TRUE;

-- ====================================================================================
-- COPY Command to Load CSV from Stage into Target Table
-- ====================================================================================
-- Replace:
--   @YOUR_STAGE/path/to/files       -> your actual stage and folder
--   YOUR_DATABASE.YOUR_SCHEMA.YOUR_TARGET_TABLE -> your actual target table

COPY INTO YOUR_DATABASE_NAME.YOUR_SCHEMA_NAME.YOUR_TARGET_TABLE
FROM (
    -- CTE-style inline SELECT used to:
    --   - Allow future transformations if needed
    --   - Make columns explicit and maintainable
    SELECT
        $1  AS COL1,  -- Replace COL1, COL2, etc. with target column names and adjust positions
        $2  AS COL2,
        $3  AS COL3,
        $4  AS COL4
        -- Add/remove columns according to your CSV and table definition
    FROM @YOUR_STAGE_NAME/path/to/files
)
FILE_FORMAT = (FORMAT_NAME = YOUR_DATABASE_NAME.YOUR_SCHEMA_NAME.FF_CSV_STANDARD)
ON_ERROR = 'CONTINUE'             -- Best practice: continue and log bad records; adjust as needed
PURGE = FALSE                     -- Set TRUE if you want files removed after successful load
FORCE = FALSE                     -- Set TRUE to reload files even if previously loaded
VALIDATION_MODE = 'NONE';         -- Use 'RETURN_ERRORS' or 'RETURN_ALL_ERRORS' for validation runs only
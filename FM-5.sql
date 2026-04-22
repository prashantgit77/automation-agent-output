-- =====================================================================
-- COPY command: Load data from CSV file in stage into Snowflake table
-- =====================================================================

COPY INTO TARGET_DB.TARGET_SCHEMA.TARGET_TABLE
FROM @TARGET_DB.TARGET_SCHEMA.TARGET_STAGE/path/to/csv/
FILES = ('your_file_name.csv')           -- Optional: specify file(s) or remove to load all
FILE_FORMAT = (
    TYPE = 'CSV'                         -- CSV file type
    FIELD_DELIMITER = ','               -- Comma-separated values
    SKIP_HEADER = 1                     -- Skip header row
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'  -- Handle quoted fields
    NULL_IF = ('\\N', 'NULL', '')       -- Treat these as NULL
    EMPTY_FIELD_AS_NULL = TRUE          -- Empty fields become NULL
    TRIM_SPACE = TRUE                   -- Trim leading/trailing spaces
)
ON_ERROR = 'ABORT_STATEMENT'            -- Fail on first error for data quality
VALIDATION_MODE = 'RETURN_ERRORS'       -- Remove or change to load data instead of just validating
PURGE = FALSE                           -- Keep files in stage after load
FORCE = FALSE;                          -- Load only new/unloaded files
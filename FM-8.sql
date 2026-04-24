-- =========================================================
-- Create table for April 26 financial data
-- =========================================================

CREATE OR REPLACE TABLE financial_april26 (
    id             VARCHAR,
    employee_name  VARCHAR,
    salary         NUMBER(10)
);

-- =========================================================
-- Load data from S3 into the financial_april26 table
-- =========================================================

COPY INTO financial_april26
FROM @ei_stag_prod/production/MonthlyData/financial/april26.csv
FILE_FORMAT = (
    TYPE = CSV
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    TRIM_SPACE = TRUE
    EMPTY_FIELD_AS_NULL = TRUE
)
ON_ERROR = 'ABORT_STATEMENT';
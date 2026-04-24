-- Create table to store April 26 financial data
CREATE OR REPLACE TABLE financial_april26 (
    id             VARCHAR,
    employee_name  VARCHAR,
    Salary         NUMBER(10,0)
);

-- Copy data from S3 into the table using existing stage
COPY INTO financial_april26
FROM @ei_stag_prod/production/MonthlyData/financial/april26.csv
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    TRIM_SPACE = TRUE
    NULL_IF = ('', 'NULL', 'null')
)
ON_ERROR = 'ABORT_STATEMENT';
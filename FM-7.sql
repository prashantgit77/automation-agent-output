-- Create table for April 26 financial data
CREATE OR REPLACE TABLE financial_april26 (
    id             VARCHAR,
    employee_name  VARCHAR,
    Salary         NUMBER(10,0)
);

-- Load data from S3 using existing stage ei_stag_prod
COPY INTO financial_april26
FROM @ei_stag_prod/production/MonthlyData/financial/april26.csv
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
)
ON_ERROR = 'ABORT_STATEMENT';
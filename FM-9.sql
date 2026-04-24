-- Use the target database and schema (adjust as needed)
USE DATABASE EI_PROD;
USE SCHEMA PUBLIC;

-- Create table for April 26 financial data
CREATE OR REPLACE TABLE FINANCIAL_APRIL26 (
    ID             VARCHAR,
    EMPLOYEE_NAME  VARCHAR,
    SALARY         NUMBER(10, 0)
);

-- Copy data from S3 into the table
COPY INTO FINANCIAL_APRIL26
FROM 's3://production/MonthlyData/financial/april26.csv'
STORAGE_INTEGRATION = ei_stag_prod
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('', 'NULL', 'null')
)
ON_ERROR = 'ABORT_STATEMENT';
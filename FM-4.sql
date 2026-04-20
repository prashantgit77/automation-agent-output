-- Create EMPLOYEE table in a production-ready manner

-- Use a dedicated schema if needed; adjust DATABASE.SCHEMA as per environment
-- Example: USE DATABASE HR_DB;
-- Example: USE SCHEMA CORE;

-- Safely drop existing table if required (optional, use with caution in non-prod)
-- DROP TABLE IF EXISTS EMPLOYEE;

CREATE OR REPLACE TABLE EMPLOYEE (
    -- Surrogate primary key for employee
    EMPLOYEE_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier for each employee',

    -- Employee full name
    EMPLOYEE_NAME VARCHAR(255) NOT NULL COMMENT 'Full name of the employee',

    -- Date employee joined the organization (no time component)
    JOINING_DATE DATE NOT NULL COMMENT 'Date when the employee joined the organization',

    -- Audit columns (recommended for production)
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'Record creation timestamp',
    UPDATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'Record last update timestamp'
)
COMMENT = 'Master table containing core employee information'
;

-- Add primary key constraint for data integrity
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT PK_EMPLOYEE
    PRIMARY KEY (EMPLOYEE_ID)
;

-- Optional: create a change tracking trigger or stream in application layer for UPDATED_AT
-- Example of an UPDATE trigger pattern is typically implemented via application logic or tasks.
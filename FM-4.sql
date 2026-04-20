```sql
-- =====================================================================
-- Create EMPLOYEE table
-- =====================================================================

-- Use a CTE to define table metadata for clarity and maintainability
WITH table_definition AS (
    SELECT 
        'EMPLOYEE'::STRING           AS table_name,
        'EMPLOYEE_ID'::STRING        AS col_employee_id,
        'EMPLOYEE_NAME'::STRING      AS col_employee_name,
        'JOINING_DATE'::STRING       AS col_joining_date
)

-- DDL statement to create the EMPLOYEE table
-- Note: This script assumes the correct database and schema are already in use
CREATE OR REPLACE TABLE EMPLOYEE (
    -- Surrogate primary key for employee; identity for automatic increment
    EMPLOYEE_ID NUMBER(38,0) 
        NOT NULL
        COMMENT 'Unique identifier for each employee',

    -- Employee full name
    EMPLOYEE_NAME VARCHAR(255)
        NOT NULL
        COMMENT 'Full name of the employee',

    -- Date the employee joined the organization
    JOINING_DATE DATE
        NOT NULL
        COMMENT 'Employee joining date',

    -- Audit columns (recommended best practice for production tables)
    CREATED_AT   TIMESTAMP_LTZ
        DEFAULT CURRENT_TIMESTAMP()
        NOT NULL
        COMMENT 'Record creation timestamp',
    UPDATED_AT   TIMESTAMP_LTZ
        DEFAULT CURRENT_TIMESTAMP()
        NOT NULL
        COMMENT 'Record last update timestamp'
)
COMMENT = 'Employee master table'
;

-- Optional: Add primary key constraint (recommended for production)
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT PK_EMPLOYEE
        PRIMARY KEY (EMPLOYEE_ID);

-- Optional: Add a trigger-like behavior using a task/stream or
-- use application logic to maintain UPDATED_AT. Example using a row-level
-- update policy should be implemented at the application layer.
```
-- Create EMPLOYEE table in a production-ready manner
CREATE OR REPLACE TABLE EMPLOYEE (
    -- Surrogate primary key for employee
    EMPLOYEE_ID      NUMBER(38,0)   NOT NULL,
    
    -- Full name of the employee
    EMPLOYEE_NAME    VARCHAR(255)   NOT NULL,
    
    -- Date when the employee joined the organization
    JOINING_DATE     DATE           NOT NULL,
    
    -- Audit columns (recommended best practice)
    CREATED_AT       TIMESTAMP_NTZ  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    UPDATED_AT       TIMESTAMP_NTZ  DEFAULT CURRENT_TIMESTAMP() NOT NULL
);

-- Add primary key constraint
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT PK_EMPLOYEE
        PRIMARY KEY (EMPLOYEE_ID);

-- Optional: Add a comment on the table for documentation
COMMENT ON TABLE EMPLOYEE IS 'Master table storing employee information including joining date.';

-- Optional: Add comments on individual columns
COMMENT ON COLUMN EMPLOYEE.EMPLOYEE_ID   IS 'Unique identifier for each employee.';
COMMENT ON COLUMN EMPLOYEE.EMPLOYEE_NAME IS 'Full name of the employee.';
COMMENT ON COLUMN EMPLOYEE.JOINING_DATE  IS 'Date when the employee joined the company.';
COMMENT ON COLUMN EMPLOYEE.CREATED_AT    IS 'Record creation timestamp.';
COMMENT ON COLUMN EMPLOYEE.UPDATED_AT    IS 'Record last update timestamp.';
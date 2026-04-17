import snowflake.connector
from snowflake.connector import ProgrammingError, OperationalError

def create_employee_table(
    user: str,
    password: str,
    account: str,
    warehouse: str,
    database: str,
    schema: str,
    role: str = None,
) -> None:
    """
    Create EMPLOYEE table in Snowflake with fields:
        1. EMPLOYEE_ID
        2. NAME
        3. JOINING_DATE

    Parameters
    ----------
    user : str
        Snowflake username
    password : str
        Snowflake password
    account : str
        Snowflake account identifier (e.g., 'abc-xy12345')
    warehouse : str
        Snowflake warehouse name
    database : str
        Snowflake database name
    schema : str
        Snowflake schema name
    role : str, optional
        Snowflake role name
    """

    conn = None
    try:
        # Establish Snowflake connection
        conn_kwargs = {
            "user": user,
            "password": password,
            "account": account,
            "warehouse": warehouse,
            "database": database,
            "schema": schema,
        }
        if role:
            conn_kwargs["role"] = role

        conn = snowflake.connector.connect(**conn_kwargs)

        create_table_sql = """
        CREATE TABLE IF NOT EXISTS EMPLOYEE (
            EMPLOYEE_ID NUMBER(38,0) NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            JOINING_DATE DATE NOT NULL,
            CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EMPLOYEE_ID)
        );
        """

        with conn.cursor() as cur:
            cur.execute(create_table_sql)

        # Commit is implicit in Snowflake for DDL, but call to be explicit
        conn.commit()

    except (ProgrammingError, OperationalError) as sf_ex:
        # Handle Snowflake-specific errors
        raise RuntimeError(f"Snowflake error during table creation: {sf_ex}") from sf_ex
    except Exception as ex:
        # Handle unexpected errors
        raise RuntimeError(f"Unexpected error during table creation: {ex}") from ex
    finally:
        # Ensure connection is closed
        if conn is not None:
            try:
                conn.close()
            except Exception:
                # Suppress any error on close to avoid masking earlier exceptions
                pass


if __name__ == "__main__":
    # Example usage: replace with real credentials or env-variable loading
    create_employee_table(
        user="YOUR_USER",
        password="YOUR_PASSWORD",
        account="YOUR_ACCOUNT",
        warehouse="YOUR_WAREHOUSE",
        database="YOUR_DATABASE",
        schema="YOUR_SCHEMA",
        role="YOUR_ROLE",
    )
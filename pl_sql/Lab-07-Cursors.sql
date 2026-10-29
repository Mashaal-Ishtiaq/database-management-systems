-- A cursor is a pointer that allows row-by-row processing of a result set.
    -- There are two types of cursors:
    -- 1. Implicit Cursor: Automatically created by Oracle for single row operations (SELECT INTO).
    -- 2. Explicit Cursor: Defined by the user for handling multiple rows.





------------------------

---Implicit Cursor

SET SERVEROUTPUT ON;

DECLARE
    -- Declare variables to store employee details
    v_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_salary EMPLOYEES.SALARY%TYPE;

BEGIN
    -- Implicit cursor: SELECT INTO automatically creates and manages the cursor
    SELECT EMPLOYEE_ID, FIRST_NAME, SALARY 
    INTO v_employee_id, v_first_name, v_salary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 101;  -- Fetch details for a specific employee

    -- Display output
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE NAME: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || v_salary);
END;
/


------------------------------------------------------------------------------

--explicit cursor
SET SERVEROUTPUT ON;

DECLARE  
    -- Declaring an explicit cursor to retrieve employee details sorted by salary (highest first).
    CURSOR Cursor_EMP IS
        SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER 
        FROM employees 
        ORDER BY salary DESC;

    -- Declaring a variable to hold the current row's data
    row_emp Cursor_EMP%ROWTYPE;

BEGIN
    -- Opening the cursor to fetch data
    OPEN Cursor_EMP;

    -- Using a loop to fetch and display all employee records one by one
    LOOP
        -- Fetch a row from the cursor into row_emp variable
        FETCH Cursor_EMP INTO row_emp;

        -- Exit loop when no more records are left
        EXIT WHEN Cursor_EMP%NOTFOUND;

        -- Displaying the employee details
        DBMS_OUTPUT.PUT_LINE(
            'EMPLOYEE ID: ' || row_emp.EMPLOYEE_ID || 
            ', EMPLOYEE NAME: ' || row_emp.FIRST_NAME || 
            ', EMPLOYEE CONTACT: ' || row_emp.PHONE_NUMBER
        );
    END LOOP;

    -- Closing the cursor to free up resources
    CLOSE Cursor_EMP;
END;
/




----------------------------------

SET SERVEROUTPUT ON;  -- Enables output for DBMS_OUTPUT.PUT_LINE

DECLARE
    -- Declare an explicit cursor to fetch employees ordered by salary (highest first)
    CURSOR Cursor_EMP IS
    SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, SALARY FROM employees ORDER BY salary DESC;

    -- Declare a record variable to store each row fetched by the cursor
    row_emp Cursor_EMP%ROWTYPE;
BEGIN
    OPEN Cursor_EMP;  -- Open the cursor to start fetching records

    LOOP
        FETCH Cursor_EMP INTO row_emp;  -- Fetch one row from the cursor into the record variable
        EXIT WHEN Cursor_EMP%NOTFOUND;  -- Exit loop if no more rows are left

        -- Print employee details to the output
        DBMS_OUTPUT.PUT_LINE(
            'EMPLOYEE ID: ' || row_emp.EMPLOYEE_ID || 
            ' | NAME: ' || row_emp.FIRST_NAME || 
            ' | CONTACT: ' || row_emp.PHONE_NUMBER || 
            ' | SALARY: ' || row_emp.SALARY
        );
    END LOOP;

    CLOSE Cursor_EMP;  -- Close the cursor after processing all records
END;
/



SELECT l.city, COUNT(e.employee_id) AS total_employees  
FROM employees e  
JOIN departments d ON e.department_id = d.department_id  
JOIN locations l ON d.location_id = l.location_id  
GROUP BY l.city  
ORDER BY total_employees DESC;

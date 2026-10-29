--simple for loop

set SERVEROUT on;

DECLARE
    counter NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Iteration: ' || counter);
        counter := counter + 1;  -- Increment counter
        
        IF counter > 5 THEN
            EXIT;  -- Exit loop after 5 iterations
        END IF;
    END LOOP;
END;
/

-----------------------------------------

---- while loop

DECLARE
    num NUMBER := 1;
BEGIN
    WHILE num <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || num);
        num := num + 1;  -- Increment
    END LOOP;
END;
/


--------------------------------
--- loop for ranges

BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Value of i: ' || i);
    END LOOP;
END;
/


---------------------------------

--for loop with database query

-- Enable output display in SQL*Plus or SQL Developer
SET SERVEROUTPUT ON;

DECLARE
BEGIN
    -- Loop through employees who belong to department ID 90
    FOR c IN (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM employees
              WHERE DEPARTMENT_ID = 90) 
    LOOP
        -- Print employee's name and salary to the output console
        DBMS_OUTPUT.PUT_LINE (
            'Salary for the employee ' || c.FIRST_NAME || ' is: ' || c.SALARY
        );
    END LOOP;
END;
/


----------------------------
---while loop with database

-- Enable output display in SQL*Plus or SQL Developer
SET SERVEROUTPUT ON;

DECLARE
    e_id employees.EMPLOYEE_ID%TYPE := 100;  -- Starting employee ID
    e_name employees.FIRST_NAME%TYPE;        -- Variable to store employee name
    e_sal employees.SALARY%TYPE;             -- Variable to store employee salary
BEGIN
    -- Check if the employee exists
    WHILE e_id <= 105 LOOP  -- Loop through employee IDs from 100 to 105
        -- Fetch employee details for the given ID
        SELECT FIRST_NAME, SALARY 
        INTO e_name, e_sal
        FROM employees 
        WHERE EMPLOYEE_ID = e_id;

        -- Print the employee's salary
        DBMS_OUTPUT.PUT_LINE (
            'Salary for employee ' || e_name || ' (ID: ' || e_id || ') is: ' || e_sal
        );

        -- Increment the employee ID for the next iteration
        e_id := e_id + 1;
    END LOOP;
END;
/

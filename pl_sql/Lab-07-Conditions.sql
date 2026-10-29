set SERVEROUTPUT on;
DECLARE 
    e_id employees.EMPLOYEE_ID%TYPE := 100;  -- Employee ID to check
    e_sal employees.SALARY%TYPE;             -- Variable to store salary
BEGIN 
    -- Fetch salary of the employee
    SELECT salary INTO e_sal 
    FROM employees 
    WHERE EMPLOYEE_ID = e_id;

    -- Update salary if it is greater than or equal to 5000
    IF e_sal >= 5000 THEN
        UPDATE employees 
        SET salary = e_sal + 1000 
        WHERE EMPLOYEE_ID = e_id;

        
        DBMS_OUTPUT.PUT_LINE('Salary updated successfully');
    END IF;
END;
/

-------------------------------------------------------------




DECLARE 
    n_count NUMBER;  -- Variable to store count of matching employee IDs
    e_id employees.EMPLOYEE_ID%TYPE := 1200;  -- Employee ID to check
BEGIN 
    -- Check if Employee ID already exists
    SELECT COUNT(1) INTO n_count 
    FROM employees 
    WHERE EMPLOYEE_ID = e_id;

    IF n_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Record already exists.');
    ELSE
        -- Insert new employee record
        INSERT INTO employees 
        (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) 
        VALUES (e_id, 'Bruce', 'Austin', 'abc', '590.423.4569', 
                TO_DATE('25-JUN-05', 'DD-MON-YY'), 'IT_PROG', 6000, 0.2, 100, 60);

        DBMS_OUTPUT.PUT_LINE('Record inserted with Employee ID: ' || e_id);
    END IF;
END;
/

--------------------------------------------------
DECLARE
    e_id employees.EMPLOYEE_ID%TYPE := 100;  -- Employee ID to check
    e_sal employees.SALARY%TYPE;             -- Variable to store salary
BEGIN
    -- Fetch salary of the employee
    SELECT salary INTO e_sal 
    FROM employees 
    WHERE EMPLOYEE_ID = e_id;

    -- Apply salary update based on conditions
    IF e_sal <= 15000 THEN
        e_sal := e_sal + 300;
    ELSIF e_sal <= 20000 THEN
        e_sal := e_sal + 200;
    ELSIF e_sal <= 25000 THEN
        e_sal := e_sal + 100;
    ELSE
        e_sal := e_sal + 400;
    END IF;

    -- Update salary in the table
    UPDATE employees 
    SET salary = e_sal 
    WHERE EMPLOYEE_ID = e_id;

    -- Display updated salary
    DBMS_OUTPUT.PUT_LINE('Salary updated: ' || e_sal);
END;
/

-------------------------------------------------------------------------

DECLARE
    e_id employees.EMPLOYEE_ID%TYPE := 100;  -- Employee ID to check
    e_sal employees.SALARY%TYPE;             -- Variable to store salary
    e_did employees.DEPARTMENT_ID%TYPE;      -- Variable to store department ID
    e_com employees.COMMISSION_PCT%TYPE;     -- Variable to store commission percentage
    updated_salary NUMBER;                   -- Variable to store updated salary
BEGIN
    -- Fetch salary, department ID, and commission percentage of the employee
    SELECT salary, DEPARTMENT_ID, COMMISSION_PCT 
    INTO e_sal, e_did, e_com 
    FROM employees 
    WHERE EMPLOYEE_ID = e_id;

    -- Check for department 90
    IF e_did = 90 THEN
        IF e_sal BETWEEN 20000 AND 250000 THEN
            updated_salary := (e_sal) * (1 + NVL(e_com, 0)); 
        ELSIF e_sal BETWEEN 15000 AND 20000 THEN
            updated_salary := (e_sal + 20) * (1 + NVL(e_com, 0)); 
        END IF;
    END IF;

    -- Check for department 40
    IF e_did = 40 THEN
        IF e_sal BETWEEN 10000 AND 15000 THEN
            updated_salary := (e_sal) * (1 + NVL(e_com, 0)); 
        ELSIF e_sal BETWEEN 5000 AND 10000 THEN
            updated_salary := (e_sal + 20) * (1 + NVL(e_com, 0)); 
        END IF;
    END IF;

    -- Perform the update if salary change is needed
    IF updated_salary IS NOT NULL THEN
        UPDATE employees 
        SET salary = updated_salary 
        WHERE EMPLOYEE_ID = e_id;
        
        
        DBMS_OUTPUT.PUT_LINE('Salary updated to: ' || updated_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No salary update required for this employee.');
    END IF;
END;
/


-------------------------------------------------------------------
-- Enables DBMS output for displaying messages
SET SERVEROUTPUT ON;  

DECLARE  
   -- Variable to store employee ID (initialized with 100)
   e_id EMPLOYEES.EMPLOYEE_ID%TYPE := 100;  
   
   -- Variables to store salary and department ID of the employee
   e_sal EMPLOYEES.SALARY%TYPE;  
   e_did EMPLOYEES.DEPARTMENT_ID%TYPE;  

BEGIN  
   -- Fetching salary and department ID of the employee with ID = e_id
   SELECT SALARY, DEPARTMENT_ID  
   INTO e_sal, e_did  
   FROM EMPLOYEES  
   WHERE EMPLOYEE_ID = e_id;  

   -- CASE statement to check department ID and update salary accordingly
   CASE e_did  
      WHEN 80 THEN  
         UPDATE EMPLOYEES SET SALARY = e_sal + 100 WHERE EMPLOYEE_ID = e_id;  
         DBMS_OUTPUT.PUT_LINE('Salary updated: ' || (e_sal + 100));  

      WHEN 50 THEN  
         UPDATE EMPLOYEES SET SALARY = e_sal + 200 WHERE EMPLOYEE_ID = e_id;  
         DBMS_OUTPUT.PUT_LINE('Salary updated: ' || (e_sal + 200));  

      WHEN 40 THEN  
         UPDATE EMPLOYEES SET SALARY = e_sal + 300 WHERE EMPLOYEE_ID = e_id;  
         DBMS_OUTPUT.PUT_LINE('Salary updated: ' || (e_sal + 300));  

      ELSE  
         -- If department ID is not 80, 50, or 40
         DBMS_OUTPUT.PUT_LINE('No such record');  
   END CASE;  
END;  
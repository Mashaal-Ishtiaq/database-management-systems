                                    --Example one
                              --VARIABLES AND PROCEDURES
-- Enable server output to display DBMS_OUTPUT messages
SET SERVEROUTPUT ON;  

-- Declare block (Optional) - Variables and constants are defined here
DECLARE  
   Sec_Name VARCHAR2(20) := 'BCS-4A';  -- Variable to store section name
   Course_Name VARCHAR2(20) := 'Database Systems Lab';  -- Variable to store course name

-- Begin block (Mandatory) - Execution starts here
BEGIN  
    -- Display concatenated message using DBMS_OUTPUT.PUT_LINE
    dbms_output.put_line('This is : ' || Sec_Name || ' and the course is ' || Course_Name);  

-- End block (Mandatory) - Marks the end of the PL/SQL block
END;  
---------------------------------------------------------------------------
                    --Tasking user input in Example One
                    
SET SERVEROUTPUT ON;  
DECLARE  
   Sec_Name VARCHAR2(20);  
   Course_Name VARCHAR2(20);  
BEGIN  
    
    Sec_Name := '&Enter_Section';  
    Course_Name := '&Enter_Course';  
    
    dbms_output.put_line('This is : ' || Sec_Name || ' and the course is ' || Course_Name);  
END;  




--------------------------------------------------------------------------
                                    --Example two
SET SERVEROUTPUT ON;  
DECLARE  
   Num1 INTEGER := 10;  -- Integer variable with initial value 10
   Num2 INTEGER := 20;  -- Integer variable with initial value 20
   summ INTEGER;  -- Integer variable to store sumu
   reaal REAL;  -- Real number variable to store division result

BEGIN  
   summ := Num1 + Num2;  -- Adding two integer values and storing result in summ
   dbms_output.put_line('Value of summ: ' || summ);  -- Displaying sum result

   reaal := 70.0 / 3.0;  -- Performing division and storing result in reaal
   dbms_output.put_line('Value of reaal: ' || reaal);  -- Displaying division result

END;  



---------------------------------------------------------------------------
                                    --Example three
DECLARE  
   -- Global variables (Available throughout the entire block)
   num1 NUMBER := 95;  
   num2 NUMBER := 85;  
BEGIN  
   dbms_output.put_line('Outer Variable num1: ' || num1);  -- Accessing global variable
   dbms_output.put_line('Outer Variable num2: ' || num2);  -- Accessing global variable

   -- Inner block starts here  
   DECLARE  
      -- Local variables (These are only accessible inside this inner block)
      -- These variables have the same name as the global ones but are treated separately
      num1 NUMBER := 195;  
      num2 NUMBER := 185;  
   BEGIN  
      -- Local variables override global ones inside this block
      dbms_output.put_line('Inner Variable num1: ' || num1);  -- Accessing inner block's local num1
      dbms_output.put_line('Inner Variable num2: ' || num2);  -- Accessing inner block's local num2
   END;  -- Inner block ends here  

   -- After inner block ends, the program goes back to using global variables
   dbms_output.put_line('Back to Outer Variable num1: ' || num1);  -- Accessing global variable again
   dbms_output.put_line('Back to Outer Variable num2: ' || num2);  -- Accessing global variable again

END;  
 
----------------------------------------------------------------------------
                                        --Example four
SET SERVEROUTPUT ON  -- Ensures output is displayed in SQL Developer

DECLARE  
   -- Declaring variables using %TYPE to match table column data types
   e_id EMPLOYEES.EMPLOYEE_ID%TYPE;  
   e_name EMPLOYEES.FIRST_NAME%TYPE;  
   e_lname EMPLOYEES.LAST_NAME%TYPE;  
   d_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;  
BEGIN  
   -- Fetching employee details along with department name using JOIN
   SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_NAME  
   INTO e_id, e_name, e_lname, d_name  -- Storing the retrieved values into variables
   FROM EMPLOYEES  
   INNER JOIN DEPARTMENTS  
   ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID  
   WHERE EMPLOYEE_ID = 100;  -- Filtering for a specific employee

   -- Displaying the retrieved values
   DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: ' || e_id);  
   DBMS_OUTPUT.PUT_LINE('EMPLOYEE First Name: ' || e_name);  
   DBMS_OUTPUT.PUT_LINE('EMPLOYEE Last Name: ' || e_lname);  
   DBMS_OUTPUT.PUT_LINE('DEPARTMENT Name: ' || d_name);  

END;  




---------------------------------------------------------------------------------
                                            --Example five

-- Enables DBMS output for displaying messages
SET SERVEROUTPUT ON  

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


----------------------------------------------------------------------------------
                                            --Example Six
--LOOP
SET SERVEROUTPUT ON;  -- Enables output display in SQL Developer

DECLARE  
BEGIN  
   -- Cursor FOR Loop: Iterates over all employees in department 90  
   FOR c IN (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY  
             FROM EMPLOYEES  
             WHERE DEPARTMENT_ID = 90)  
   LOOP  
      -- Printing each employee’s first name and salary  
      DBMS_OUTPUT.PUT_LINE('Salary for the employee ' || c.FIRST_NAME || ' is: ' || c.SALARY);  
   END LOOP;  
END;  



-----------------------------------------------------------------------------
                                        --Example Seven
---VIEWS--
--SIMPLE VIEW--
-- Creating or replacing a view named 'simple_employee_view'
CREATE OR REPLACE VIEW simple_employee_view_dep_ninty AS  
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, SALARY  
FROM EMPLOYEES  
WHERE DEPARTMENT_ID = 90;  -- Only employees from department 80 are included  

-- Fetching data from the created view  
SELECT * FROM simple_employee_view_dep_ninty;  




-----------------------------------------------------------------------------
                                        --Example Eight
--COMPLEX VIEW
-- Creating or replacing a view named 'complx_emp_dpt_view'
CREATE OR REPLACE VIEW complx_emp_dpt_view AS  
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, e.SALARY  
FROM EMPLOYEES e  
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID  -- Joining employees with departments  
WHERE e.SALARY > 5000;  -- Only employees with salary greater than 5000  

-- Fetching data from the created view  
SELECT first_name , department_name FROM complx_emp_dpt_view;  


----------------------------------------------------------------------------
                                        --Example Nine
--MATERIALIZED VIEW
-- Creating a materialized view named 'employee_salary_summary'
CREATE MATERIALIZED VIEW employee_salary_summary AS  
SELECT  
    d.DEPARTMENT_NAME,  
    COUNT(e.EMPLOYEE_ID) AS employee_count,  -- Counting employees per department  
    AVG(e.SALARY) AS average_salary          -- Calculating average salary per department  
FROM EMPLOYEES e  
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID  -- Joining with departments  
GROUP BY d.DEPARTMENT_NAME;  -- Grouping data by department name  

-- Fetching data from the materialized view  
SELECT * FROM employee_salary_summary;  




---------------------------------------------------------------------------------
                                        --Example Ten
--FUNCTIONS
-- Creating or replacing a function named 'CalculateSAL'
CREATE OR REPLACE FUNCTION CalculateSAL(  
    DEPT_ID IN NUMBER  -- Input parameter: Department ID  
) RETURN NUMBER  -- Function returns a number (total salary)  
IS  
    Total_Salary NUMBER := 0;  -- Variable to store the total salary  
BEGIN  
    -- This query calculates the sum of salaries for the given department  
    SELECT SUM(Salary)  
    INTO Total_Salary  
    FROM employees  
    WHERE DEPARTMENT_ID = DEPT_ID;  

    -- Returning the calculated total salary  
    RETURN Total_Salary;  
END;  
/  

-- Calling the function for department 80  
SELECT CalculateSAL(80) FROM dual;  


----------------------------------------------------------------------------------
                                            --Example Eleven
--Store procedures
-- Procedure ko create ya replace karte hue 'all_employees' naam se
CREATE OR REPLACE PROCEDURE all_employees
AS
BEGIN
  -- Employees table se saare records select karte hue cursor FOR loop ka istemal
  FOR emp_rec IN (SELECT * FROM employees) LOOP
    -- Har employee ka detail display karte hue
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.employee_id || 
                         ', First Name: ' || emp_rec.first_name || 
                         ', Last Name: ' || emp_rec.last_name ||
                         ', Department ID: ' || emp_rec.department_id);
  END LOOP;
END;
/
execute all_employees;

---------------------------------------------------------------------
                                    --Example Twelev
---FOR INSERTING DATA STORE PROCEDURE
CREATE OR REPLACE PROCEDURE insert_unique_employee (
    p_employee_id   IN NUMBER,
    p_first_name    IN VARCHAR2,
    p_last_name     IN VARCHAR2,
    p_email         IN VARCHAR2,
    p_phone_number   IN VARCHAR2,
    p_hire_date     IN DATE,
    p_job_id        IN VARCHAR2,
    p_salary        IN NUMBER,
    p_commission_pct IN NUMBER,
    p_manager_id    IN NUMBER,
    p_department_id IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Check if the employee ID or email already exists
    SELECT COUNT(*)
    INTO v_count
    FROM employees
    WHERE employee_id = p_employee_id OR email = p_email;

    IF v_count = 0 THEN
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        ) VALUES (
            p_employee_id,
            p_first_name,
            p_last_name,
            p_email,
            p_phone_number,
            p_hire_date,
            p_job_id,
            p_salary,
            p_commission_pct,
            p_manager_id,
            p_department_id
        );

        DBMS_OUTPUT.PUT_LINE('Employee ' || p_first_name || ' ' || p_last_name || ' inserted successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID or Email already exists. Insertion failed for ' || p_first_name || ' ' || p_last_name);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


BEGIN
    insert_unique_employee(
        p_employee_id   => 2005, 
        p_first_name    => 'Eva',
        p_last_name     => 'Green',
        p_email         => 'eva.green@example.com',
        p_phone_number   => '555-3698',
        p_hire_date     => TO_DATE('2024-10-24', 'YYYY-MM-DD'),
        p_job_id        => 'IT_PROG',
        p_salary        => 6200,
        p_commission_pct => 0.05,
        p_manager_id    => 102,
        p_department_id => 60
    );
END;


---Cursor--
SET SERVEROUTPUT ON;
DECLARE
  CURSOR Cursor_EMP IS
  SELECT * FROM employees ORDER BY salary DESC;
   -- record    
   row_emp Cursor_EMP%ROWTYPE;
BEGIN
  OPEN Cursor_EMP;
  LOOP
    FETCH  Cursor_EMP  INTO row_emp;
    EXIT WHEN Cursor_EMP%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( 'EMPLOYEE id: ' ||row_emp.EMPLOYEE_ID || ' EMPLOYEE NAME: ' || row_emp.FIRST_NAME || ' EMPLOYEE CONTACT: ' || row_emp.PHONE_NUMBER || '.');
  END LOOP;
  CLOSE Cursor_EMP;
END;



---------

SET SERVEROUTPUT ON;

Declare
n_count number;
e_id employees.EMPLOYEE_ID%type := 1100; 
Begin
Select count(1) into n_count from employees	Where EMPLOYEE_ID = e_id; if n_count > 0 then
dbms_output.put_line('record already exists.'); 
else
INSERT INTO employees

(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_ pct,manager_id,department_id)
VALUES (e_id,'Bruce','Austin','DAUSTIN7','590.423.4569','25-JUN- 05','IT_PROG',6000,0.2,100,60);
dbms_output.put_line('record inserted with Employee ID: ' ||e_id); end if;
End;


-- Scalar Value Functions in SQL:
-- A Scalar Value Function is a user-defined function that returns a single value 
-- (such as a number, string, or date) for each input parameter.
-- It is useful for calculations or data transformations that return a single result.

-- Example: A function to calculate the yearly salary of an employee
CREATE OR REPLACE FUNCTION get_yearly_salary (p_employee_id NUMBER)
RETURN NUMBER
IS
  
  v_monthly_salary NUMBER;
  v_yearly_salary NUMBER;
BEGIN

  SELECT salary INTO v_monthly_salary
  FROM employees
  WHERE employee_id = p_employee_id;
  
  
  v_yearly_salary := v_monthly_salary * 12;

  RETURN v_yearly_salary;
END;
/


select get_yearly_salary(110) as early_salary from dual;

------------------------------------


-- INLINE TABLE-VALUED FUNCTION (ITVF) EXPLANATION:
-- A table-valued function returns a set of rows instead of a single value.
-- The function acts like a virtual table that can be queried using SELECT.
-- In Oracle, we use PIPELINED functions to return table-like results.


-- Step 1: Create an object type to define the structure of each employee record  
CREATE OR REPLACE TYPE emp_record AS OBJECT (
    employee_id NUMBER,    
    first_name VARCHAR2(50),  
    last_name VARCHAR2(50),  
    salary NUMBER          
);
/  

drop type emp_record force;
drop function get_employees_by_department;

-- Step 2: Create a table type to hold multiple employee records  
CREATE OR REPLACE TYPE emp_table AS TABLE OF emp_record;  
/  

-- Step 3: Create an inline table-valued function that returns employees of a specific department  
CREATE OR REPLACE FUNCTION get_employees_by_department (p_department_id NUMBER)  
RETURN emp_table PIPELINED  -- The PIPELINED keyword makes it return rows like a table
IS  
BEGIN  
  -- Step 4: Fetch employees from the employees table based on department ID  
  FOR emp IN (SELECT employee_id, first_name, last_name, salary   
              FROM employees   
              WHERE department_id = p_department_id)  
  LOOP  
    -- Step 5: Pipe each employee record as an instance of emp_record  
    PIPE ROW (emp_record(emp.employee_id, emp.first_name, emp.last_name, emp.salary));  
  END LOOP;  
  
  -- Step 6: Return the final result set  
  RETURN;  
END;  
/  
 
-- Step 7: Execute the function to fetch employees of department 50  
SELECT * FROM TABLE(get_employees_by_department(90));  

-- HOW IT WORKS:
-- 1. The function takes a department ID as input.
-- 2. It retrieves employees from that department.
-- 3. Each row is piped into the output dynamically.
-- 4. The function is used like a table in the SELECT statement.



-------------------------------------------------------------------

-- Multi-Statement Table-Valued Function (MSTVF)

/* MSTVF allows us to perform **multiple operations** (like calculations, conditions)
-before returning a table result.
-Unlike inline functions, MSTVF **stores data in a table variable** and **modifies it** before returning.
-It is useful when we need **complex processing** before sending results
*/
-- Step 1: Create an object type to define the structure of the result  
CREATE OR REPLACE TYPE emp_performance AS OBJECT (  
    employee_id NUMBER,  
    first_name VARCHAR2(50),  
    last_name VARCHAR2(50),  
    salary NUMBER,  
    performance_rating VARCHAR2(50)  
);  
/  

-- Step 2: Create a table type to store multiple employee records  
CREATE OR REPLACE TYPE emp_perf_table AS TABLE OF emp_performance;  
/  

-- Step 3: Create the Multi-Statement Table-Valued Function  
CREATE OR REPLACE FUNCTION get_employee_performance (p_department_id NUMBER)  
RETURN emp_perf_table  
IS  


  emp_list emp_perf_table := emp_perf_table();  -- Initialize empty table  
  v_rating VARCHAR2(50);  -- Variable for performance rating  
BEGIN  
  -- Fetch employees and assign performance ratings  
  FOR emp IN (SELECT employee_id, first_name, last_name, salary  
              FROM employees  
              WHERE department_id = p_department_id)  
  LOOP  
    -- Determine performance rating based on salary  
    IF emp.salary > 10000 THEN  
      v_rating := 'High Performer';  
    ELSIF emp.salary BETWEEN 5000 AND 10000 THEN  
      v_rating := 'Average Performer';  
    ELSE  
      v_rating := 'Needs Improvement';  
    END IF;  

    -- Add record to the table  
    emp_list.EXTEND;  
    emp_list(emp_list.LAST) := emp_performance(emp.employee_id, emp.first_name, emp.last_name, emp.salary, v_rating);  
  END LOOP;  

  RETURN emp_list;  -- Return the final table  
END;  
/  

-- Step 4: Run the function to see results  
SELECT * FROM TABLE(get_employee_performance(50));  

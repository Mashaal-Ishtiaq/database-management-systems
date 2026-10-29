---VIEWS--
--SIMPLE VIEW updateable--
-- Creating or replacing a view named 'simple_employee_view'

-- Step 1: Creating a Simple View  
-- This view includes employees from department 80  
CREATE OR REPLACE VIEW simple_employee_view AS  
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, SALARY  
FROM EMPLOYEES  
WHERE DEPARTMENT_ID = 80;  

-- Step 2: Selecting Data from the View  
-- Fetching the initial data to see existing records  
SELECT * FROM simple_employee_view;  

-- Step 3: Updating Salary Using the View  
-- This update modifies the salary in both the view and the base table  
UPDATE simple_employee_view  
SET SALARY = SALARY + 1000  
WHERE EMPLOYEE_ID = 145;  

-- Step 4: Selecting Data from the View Again  
-- Checking if the changes reflect in the view  
SELECT * FROM simple_employee_view;  

-- Step 5: Selecting Data from the Master Table  
-- Verifying if the update is also applied to the main `EMPLOYEES` table  
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 145;  



----------------------------------------


-- Step 1: Creating a Complex View as READ-ONLY
CREATE OR REPLACE VIEW complx_emp_dpt_view AS  
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, e.SALARY  
FROM EMPLOYEES e  
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID  -- Joining employees with departments  
WHERE e.SALARY > 5000;  -- Only employees with salary greater than 5000  
--WITH READ ONLY;  -- This makes the view non-updateable

-- Step 2: Selecting Data from the View  
-- This allows us to see the data but prevents updates, inserts, and deletes.  
SELECT * FROM complx_emp_dpt_view;  

-- WHY IS THIS VIEW READ-ONLY?  
-- 1. **Contains a JOIN:** Data is retrieved from multiple tables (EMPLOYEES and DEPARTMENTS), so direct updates could cause integrity issues.  
-- 2. **Uses a WHERE Condition:** Employees with salary ? 5000 are excluded, making it impossible to ensure all updates meet this condition.  
-- 3. **Includes a Derived Column:** DEPARTMENT_NAME comes from DEPARTMENTS, not EMPLOYEES, so modifying it directly is not allowed.  
-- 4. **Explicit READ ONLY Clause:** This prevents accidental updates and ensures data integrity.  

-- Step 3: Attempting to Update (This Will Fail)  
UPDATE complx_emp_dpt_view  
SET SALARY = SALARY + 1000  
WHERE EMPLOYEE_ID = 101;  

-- ERROR: ORA-42399: cannot perform DML operations on a read-only view  

-- Step 4: Verifying That the Master Table is Unaffected  
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 101;  -- No changes occur in the base table  


------------------

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

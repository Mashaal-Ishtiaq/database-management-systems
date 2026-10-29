/*  
    Calculating Average Salary by Department  
    - Groups employees by department_id to compute averages per department  
    - Uses AVG() to calculate the average salary  
    - GROUP BY is required because AVG() operates on groups, not individual rows  
*/

SELECT  
    AVG(salary) AS "average_salary"  
FROM  
    employees  
GROUP BY department_id;  -- Ensures AVG() is calculated separately for each department  

--------------------
/*  
    Calculate Total Salary by Department  
    - Groups employees by department_id to calculate salary per department  
    - Uses SUM() to get total salary for each department  
    - HAVING is used instead of WHERE because SUM() is an aggregate function  
*/

SELECT department_id, SUM(salary) AS "Total Salary"  
FROM employees  
GROUP BY department_id  -- Needed to apply SUM() per department  
HAVING SUM(salary) < 100000;  -- Filters only departments with total salary below 100,000  



----------------------------------------

/*  
    Find Lowest Salary by Department  
    - Groups employees by department_id to find the lowest salary in each department  
    - Uses MIN() to get the minimum salary  
    - GROUP BY is required to apply MIN() per department  
    - HAVING is used instead of WHERE because MIN() is an aggregate function  
*/

SELECT Department_ID,   
MIN(salary) AS "Lowest Salary"  
FROM employees  
GROUP BY Department_ID   
HAVING MIN(salary) < 15000;    


------------------------------

/*  
    Find Highest Salary by Department  
    - Groups employees by department_id to find the highest salary in each department  
    - Uses MAX() to get the maximum salary  
    - GROUP BY is required to apply MAX() per department  
    - HAVING is used instead of WHERE because MAX() is an aggregate function  
*/

SELECT Department_ID,  
MAX(salary) AS "Highest Salary"  
FROM employees  
GROUP BY Department_ID  -- Ensures MAX() is calculated for each department  
HAVING MAX(salary) > 3000;  -- Filters departments where the highest salary is above 3,000  

------------------------------------

/*  
    Find Employees with the Same Job as a Specific Employee  
    - Retrieves first_name and job_id of employees  
    - Uses a subquery to find job_id of employee with empno 109  
    - WHERE clause filters employees with the same job_id  
*/

SELECT First_Name, Job_ID  
FROM Employees  
WHERE Job_ID = (SELECT Job_ID FROM Employees WHERE EMPLOYEE_ID = 109);  

select * from employees where JOB_ID='FI_ACCOUNT';
---------------------------------

/*  
    Find Employee with the Highest Salary  
    - Selects employee_id, first_name, last_name, and salary  
    - Uses a subquery to get the maximum salary from the employees table  
    - Filters employees whose salary matches the highest salary  
*/

SELECT  
    employee_id, first_name, last_name, salary  
FROM  
    employees  
WHERE  
    salary = (SELECT MAX(salary) FROM employees);  -- Finds employees with the highest salary  


----------------------------------------
/*  
    Find Employees Earning Above Average Salary  
    - Selects employee_id, first_name, last_name, and salary  
    - Uses a subquery to calculate the average salary from the employees table  
    - Filters employees whose salary is greater than the calculated average  
*/

SELECT  
    employee_id, first_name, last_name, salary  
FROM  
    employees  
WHERE  
    salary > (SELECT AVG(salary) FROM employees);  -- Compares salary with the average salary  

------------------------------------------

/*  
    Find Employees Working in a Specific Location  
    - Selects first_name and department_id of employees  
    - Uses a subquery to find department_ids from the departments table where LOCATION_ID = 100  
    - Filters employees whose department_id matches the retrieved department_ids  
*/

SELECT first_name, department_id  
FROM employees  
WHERE department_id IN (  
    SELECT department_id  
    FROM departments  
    WHERE location_id = 100  
);  -- Finds employees in departments located at LOCATION_ID 100  

------------------------------------

/*  
    Find Employees Earning Less Than Any 'PU_CLERK' Salary  
    - Selects employee_id, first_name, and job_id from employees  
    - Uses a subquery to get all salaries of employees with job_id 'PU_CLERK'  
    - ANY allows comparison with each value in the subquery result  
    - Filters employees whose salary is less than at least one 'PU_CLERK' salary  
*/

SELECT employee_ID, First_Name, job_ID  
FROM EMPLOYEES  
WHERE SALARY < ANY (  
    SELECT salary  
    FROM EMPLOYEES  
    WHERE JOB_ID = 'PU_CLERK'  
);  -- Finds employees earning less than at least one 'PU_CLERK' salary  


----------------------------------

/*  
    Find Employees Earning More Than All 'PU_CLERK' Salaries  
    - Selects employee_id, first_name, and job_id from employees  
    - Uses a subquery to get all salaries of employees with job_id 'PU_CLERK' from HR.EMPLOYEES  
    - ALL ensures the salary is greater than every salary in the subquery result  
    - AND job_ID <> 'PU_CLERK' excludes 'PU_CLERK' employees from the result  
*/

SELECT employee_ID, First_Name, job_ID  
FROM EMPLOYEES  
WHERE SALARY > ALL (  
    SELECT salary  
    FROM HR.EMPLOYEES  
    WHERE JOB_ID = 'PU_CLERK'  
)  
AND job_ID <> 'PU_CLERK';  -- Ensures only non-'PU_CLERK' employees are included  


-----------------------

/*  
    Find Departments with Above-Average Salary  
    - Selects department_name and average salary from EMP_DETAILS_VIEW  
    - Uses GROUP BY to calculate average salary per department  
    - HAVING is used to filter departments with an average salary higher than the overall average  
    - The subquery calculates the overall average salary from the EMPLOYEES table  
*/

SELECT department_name, AVG(salary)  
FROM EMP_DETAILS_VIEW  
GROUP BY department_name  
HAVING AVG(salary) > (  
    SELECT AVG(salary)  
    FROM EMPLOYEES  
);  -- Filters departments where the average salary is above the company-wide average  

-----------------------------

/*  
    Insert Employees with Job Title 'Accountant' into Backup Table  
    - Copies records from EMPLOYEES to EMPLOYEE_BKP  
    - Uses a subquery to find job_IDs where job_title is 'Accountant' from the JOBS table  
    - Filters EMPLOYEES table to insert only those employees with the retrieved job_IDs  
*/

create table EMPLOYEE_BKP as select * from EMPLOYEES where 1=;

INSERT INTO EMPLOYEE_BKP  
SELECT *  
FROM EMPLOYEES  
WHERE job_ID IN (  
    SELECT job_id  
    FROM jobs  
    WHERE job_title = 'Accountant'  
);  -- Inserts only employees with the job title 'Accountant' into EMPLOYEE_BKP  


select * from EMPLOYEE_BKP;

------------------------------------

/*  
    Increase Salary by 10% for Specific Employees  
    - Updates the salary of employees by increasing it by 10%  
    - Uses a subquery to find job_IDs where the min_salary is 3000 from the JOBS table  
    - Updates only those employees whose job_ID matches the retrieved job_IDs  
*/

UPDATE employees  
SET salary = salary + (0.1 * salary)  -- Increases salary by 10%  
WHERE job_ID IN (  
    SELECT job_ID  
    FROM jobs  
    WHERE min_salary = 3000  
);  -- Applies update only to employees with job_IDs where min_salary is 3000  


---------------------------

/*  
    Delete Employees from Backup Table Based on Job History  
    - Deletes records from the EMPLOYEE_BKP table  
    - Uses a subquery to find job_IDs from the JOB_HISTORY table where end_Date is '31-Dec-06'  
    - Deletes only those employees whose job_ID matches the retrieved job_IDs  
*/

DELETE FROM employee_BKP  
WHERE job_ID IN (  
    SELECT job_ID  
    FROM job_History  
    WHERE end_Date = '31-Dec-06'  
);  -- Removes employees who had their job end on '31-Dec-06' from EMPLOYEE_BKP  

-------------------------------



/*  
    Retrieve Employee Details with Job, Department, Location, and Region  
    - Selects employee_id, first_name, and last_name from EMPLOYEES  
    - Uses subqueries to fetch related job title, department name, city (department location), and region name  
    - Joins EMPLOYEES (e) with DEPARTMENTS (d), LOCATIONS (l), and REGIONS (r)  
    - Filters data based on department and location relationships  
*/

SELECT  
    e.employee_id,  
    e.first_name,  
    e.last_name,  
    (SELECT job_title FROM jobs WHERE job_id = e.job_id) AS job_title,  -- Fetches job title using subquery  
    (SELECT department_name FROM departments WHERE department_id = e.department_id) AS department_name,  -- Gets department name  
    (SELECT city FROM locations WHERE location_id = d.location_id) AS department_location,  -- Fetches city from locations  
    (SELECT region_name FROM regions WHERE region_id = r.region_id) AS region_name  -- Retrieves region name  
FROM  
    employees e,  
    departments d,  
    locations l,  
    regions r  
WHERE  
    e.department_id = d.department_id  -- Links employees to departments  
    AND d.location_id = l.location_id;  -- Links departments to locations  


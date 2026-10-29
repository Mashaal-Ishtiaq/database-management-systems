/*                                  Understanding the Not Null Constraint

    Step 1: Creating a table WITHOUT NOT NULL constraint   
    Initially, we are creating a table where 's_name' is NOT NULL,  
    but other columns can accept NULL values.  
*/

--Remeber Testting_not_null is not a good its just for table but we are adding
--it to understand the constraint better
CREATE TABLE testing_not_null (  
    s_name VARCHAR(50) NOT NULL,  -- Name is mandatory  
    s_email VARCHAR(50),  -- Currently, email can be NULL  
    s_password VARCHAR(255),  -- Currently, password can be NULL  
    s_semester VARCHAR(20),  -- Optional field  
    s_cgpa DECIMAL(3,2)  -- Optional field  
);

/*  
    Step 2: Now, we realize that 's_email' and 's_password' should also be NOT NULL.  
    Instead of recreating the table, we will use ALTER TABLE.  
*/

/*  
    Step 3: Adding NOT NULL Constraint using ALTER TABLE  
    We modify 's_email' and 's_password' to ensure they cannot have NULL values.  
*/

ALTER TABLE testing_not_null MODIFY s_email VARCHAR(50) NOT NULL;  
ALTER TABLE testing_not_null MODIFY s_password VARCHAR(255) NOT NULL;  

/*  
    Step 4: Testing the Constraint   
    If we try to insert a record without 's_email' or 's_password', it will FAIL.  
*/

-- This will FAIL because 's_email' is NULL  
INSERT INTO testing_not_null (s_name, s_email, s_password)  
VALUES ('Yasir Arfat', NULL, 'securepass');  

-- ERROR: Column 's_email' cannot be NULL  

-- This will FAIL because 's_password' is NULL  
INSERT INTO testing_not_null (s_name, s_email, s_password)  
VALUES ('Yasir Arfat', 'Yasir.arafat@nu.edu.pk', NULL);  

-- ERROR: Column 's_password' cannot be NULL  

/*  
    Conclusion:  
    1. Initially, 's_email' and 's_password' could be NULL.  
    2. We added the NOT NULL constraint using ALTER TABLE.  
    3. Now, they must have values; otherwise, an error occurs.  
*/

--correct insertion

INSERT INTO testing_not_null (s_name, s_email, s_password)  
VALUES ('Yasir Arfat', 'Yasir.arafat@nu.edu.pk', 'securepass');

select * from testing_not_null;

-----------------------------------------------------------------------------



/*                  Understanding the Not Unique constraint Constraint  
    Step 1: Creating a table with a UNIQUE constraint    
    - 's_email' is UNIQUE, so duplicate emails are not allowed.  
    - Other fields do not have UNIQUE constraint initially.  
*/

CREATE TABLE testing_unique (
    s_name VARCHAR(25) NOT NULL,  
    s_email VARCHAR(50) NOT NULL UNIQUE,  -- Email must be unique  
    s_password VARCHAR(30) NOT NULL,  
    s_semester VARCHAR(23) NOT NULL,  
    s_cgpa VARCHAR(24) NOT NULL  
);

/*  
    Step 2: Adding a UNIQUE constraint later using ALTER TABLE   
    Suppose we forgot to make 's_name' UNIQUE during table creation,  
    we can still enforce it using ALTER TABLE.  
*/

ALTER TABLE testing_unique ADD UNIQUE(s_name);  

/*  
    Step 3: Adding a UNIQUE constraint for multiple columns    
    - If we want to ensure that the combination of 's_semester' and 's_cgpa' is unique,  
      we use a composite UNIQUE constraint.  
*/

ALTER TABLE testing_unique ADD CONSTRAINT const_unique UNIQUE(s_semester, s_cgpa);  

/*  
    Step 4: Dropping a UNIQUE constraint   
    - If later we decide to remove the unique constraint on 's_semester' and 's_cgpa',  
      we can drop it using the following command.  
*/

ALTER TABLE testing_unique DROP CONSTRAINT const_unique;  

/*  
    Testing UNIQUE Constraint    
    - If we try to insert a record with a duplicate 's_email' or 's_name', it will FAIL.  
*/

-- This will work  
INSERT INTO testing_unique (s_name, s_email, s_password, s_semester, s_cgpa)  
VALUES ('Yasir Arfat', 'yasir.arafat@nu.edu.pk', 'securepass', 'Fall 2025', '3.5');  

-- This will FAIL because 's_email' must be UNIQUE  
INSERT INTO testing_unique (s_name, s_email, s_password, s_semester, s_cgpa)  
VALUES ('Yasir Arfat', 'yasir.arafat@nu.edu.pk', 'securepass', 'Fall 2025', '3.7');  

-- ERROR: Duplicate entry 'yasir.arafat@nu.edu.pk' for key 's_email'  



-----------------------------------------------------------------------------------


/*                      Understanding the Primary Key Constraint
    Step 1: Creating a table with a PRIMARY KEY directly  
    - 's_id' is set as the PRIMARY KEY during table creation.  
    - This means each value in 's_id' must be UNIQUE and cannot be NULL.  
*/

CREATE TABLE testing_pk (
    s_id INT PRIMARY KEY,  -- 's_id' uniquely identifies each record  
    s_name VARCHAR(25) NOT NULL,  
    s_email VARCHAR(50),  
    s_password VARCHAR(30),  
    s_semester VARCHAR(23),  
    s_cgpa VARCHAR(24)  
);

/*  
    Step 2: Dropping the table   
    - If we want to redefine the PRIMARY KEY, we need to drop and recreate the table.  
*/

DROP TABLE testing_pk;  

/*  
    Step 3: Creating the table WITHOUT a PRIMARY KEY  
    - This time, we create the table without defining a PRIMARY KEY.  
    - We will add the PRIMARY KEY later using ALTER TABLE.  
*/

CREATE TABLE testing_pk (
    s_id INT,  -- No PRIMARY KEY yet  
    s_name VARCHAR(25) NOT NULL,  
    s_email VARCHAR(50),  
    s_password VARCHAR(30),  
    s_semester VARCHAR(23),  
    s_cgpa VARCHAR(24)  
);

/*  
    Step 4: Adding PRIMARY KEY using ALTER TABLE  
    - Now, we add the PRIMARY KEY to 's_id' using ALTER TABLE.  
    - This ensures that 's_id' values must be unique and not null.  
*/

ALTER TABLE testing_pk ADD PRIMARY KEY (s_id);  

/*  
    Step 5: Creating a COMPOSITE PRIMARY KEY    
    - A composite primary key means TWO OR MORE columns together act as a unique identifier.  
    - Here, we define 's_id' and 's_name' as a composite primary key.  
    - This means the same 's_id' can exist if 's_name' is different, and vice versa.  
*/

ALTER TABLE testing_pk ADD CONSTRAINT composite_pk PRIMARY KEY (s_id, s_name);  

/*  
    Step 6: Dropping the Composite PRIMARY KEY Constraint  
    - If we want to remove the composite primary key constraint, we can drop it.  
*/

ALTER TABLE testing_pk DROP CONSTRAINT composite_pk;  

/*  
    Summary:  
    --------  
    1. We first created a table with a PRIMARY KEY directly.  
    2. Then, we dropped the table and created it without a PRIMARY KEY.  
    3. We used ALTER TABLE to add a PRIMARY KEY later.  
    4. We demonstrated how to create and drop a composite PRIMARY KEY.  
*/


--------------------------------------------------------------------------------------------



/*                  Understanding the  Foreign key constraint 
    Step 1: Creating the Parent Table (Department Table)  
    - 'Department' table with 'd_id' as the PRIMARY KEY.  
    - Each department has a unique 'd_id' and a 'd_name' (department name).  
*/

CREATE TABLE Department (
    d_id INT PRIMARY KEY,  -- Unique department ID  
    d_name VARCHAR(50)  -- Department name  
);

/*  
    Step 2: Creating the Child Table (Employee Table) with a FOREIGN KEY  
    - 'Employee' table has a 'd_id' column, which references the 'd_id' column in the 'Department' table.  
    - The FOREIGN KEY constraint ensures that 'd_id' in 'Employee' matches an existing 'd_id' in 'Department'.  
*/

CREATE TABLE Employee (
    e_id INT PRIMARY KEY,  -- Unique employee ID  
    e_name VARCHAR(50) NOT NULL,  -- Employee name  
    d_id INT,  -- Foreign key column (references Department's d_id)  
    CONSTRAINT fk_d_id FOREIGN KEY (d_id) REFERENCES Department(d_id)  
);

/*  
    Step 3: Dropping the FOREIGN KEY Constraint  
    -------------------------------------------  
    - If we need to remove the FOREIGN KEY constraint later, 
    we can use ALTER TABLE to drop it.  
*/

ALTER TABLE Employee DROP CONSTRAINT fk_d_id;  

/*  
    Step 4: Adding a FOREIGN KEY using ALTER TABLE  
    ----------------------------------------------  
    - If we forgot to add the FOREIGN KEY during table creation,  
      we can still add it later using ALTER TABLE.  
*/

ALTER TABLE Employee ADD CONSTRAINT fk_d_id FOREIGN KEY 
(d_id) REFERENCES Department(d_id);  

/*  
    Testing FOREIGN KEY Constraint  
    ------------------------------  
    - Trying to insert an employee with a 'd_id' that does not 
    exist in 'Department' will FAIL.  
*/

-- This will FAIL because department ID 100 does not exist  
INSERT INTO Employee (e_id, e_name, d_id) VALUES (1, 'Ali Khan', 100);  

-- ERROR: Cannot add or update a child row: a foreign key constraint fails  

-- First, insert a matching department into the 'Department' table  
INSERT INTO Department (d_id, d_name) VALUES (100, 'Information Technology Department');  

-- Now this will work because 'd_id' 100 exists in the 'Department' table  
INSERT INTO Employee (e_id, e_name, d_id) VALUES (1, 'Ali Khan', 100);  

/*  
    Summary:  
    --------  
    1. Created the parent table 'Department' with 'd_id' as PRIMARY KEY.  
    2. Created the child table 'Employee' with 'd_id' as FOREIGN KEY referencing 'Department'.  
    3. Demonstrated how to drop and add a FOREIGN KEY using ALTER TABLE.  
    4. Tested the FOREIGN KEY constraint by inserting invalid and valid records.  
*/

---------------------------------------------------------

/*                  Understanding the Check Constraint
    Step 1: Creating a Table with a CHECK Constraint  
    - We create a table 'testing_check' with 'id' as the PRIMARY KEY.  
    - 'age' must be 18 or older, and 'salary' is a positive number due to the CHECK constraint.  
*/

CREATE TABLE testing_check (
    id INT PRIMARY KEY,  -- Unique ID for each record  
    age INT,  -- Age of the person  
    salary NUMBER,  -- Salary of the person  
    CONSTRAINT chk_age CHECK (age >= 18)  -- Ensures that age is at least 18  
);

/*  
    Step 2: Adding a CHECK Constraint Using ALTER TABLE  
    - If we need to add a CHECK constraint later, we can use ALTER TABLE.  
    - Here, we are ensuring that 'salary' must be greater than 0.  
*/

ALTER TABLE testing_check ADD CONSTRAINT chk_salary CHECK (salary > 0);  

/*  
    Step 3: Dropping the CHECK Constraint  
   - If we want to remove the CHECK constraint, we can use ALTER TABLE to drop it.  
    - Here, we are dropping the 'chk_salary' constraint.  
*/

ALTER TABLE testing_check DROP CONSTRAINT chk_salary;  

/*  
    Testing CHECK Constraint  
    - If we try to insert a record with age less than 18, it will fail.  
    - Similarly, if salary is less than or equal to 0, it will also fail.  
*/

-- This will FAIL because age is less than 18  
INSERT INTO testing_check (id, age, salary) VALUES (1, 16, 5000);  
-- ERROR: Check constraint failed  

-- This will FAIL because salary is less than or equal to 0  
INSERT INTO testing_check (id, age, salary) VALUES (2, 20, -5000);  
-- ERROR: Check constraint failed  

-- This will WORK because age is greater than or equal to 18 and salary is positive  
INSERT INTO testing_check (id, age, salary) VALUES (3, 25, 5000);  

/*  
    Summary:  
    --------  
    1. We created a table with a CHECK constraint on 'age' to ensure it is at least 18.  
    2. We added a CHECK constraint later on 'salary' to ensure it is greater than 0.  
    3. We demonstrated how to drop a CHECK constraint using ALTER TABLE.  
    4. We tested the constraints by trying to insert invalid values for age and salary.  
*/



------------------------------------------------

/*                Understanding the Default Constraint          
    Step 1: Creating a Table with a DEFAULT Value  
    - We create a table 'testing_default' where the 'salary' column has a default value of 50000.  
    - If no salary is provided during insertion, the default value (50000) will be used automatically.  
*/

CREATE TABLE testing_default (
    id INT PRIMARY KEY,  -- Unique ID for each record  
    name VARCHAR(50),  -- Name of the person  
    salary NUMBER DEFAULT 50000  -- Default salary is 50000 if not specified  
);

/*  
    Step 2: Modifying the DEFAULT Value Using ALTER TABLE  
    - If we want to change the default value of 'salary' after the table has been created,  
      we can use ALTER TABLE to modify the default.  
    - Here, we change the default salary to 70000.  
*/

ALTER TABLE testing_default 
MODIFY salary DEFAULT 70000;  

/*  
    Testing DEFAULT Constraint  
    - If we insert a record without specifying the 'salary', the default value will be used.  
    - In this case, if no salary is provided, it will be set to 70000 (after modification).  
*/

-- This will insert with salary = 70000 (default)  
INSERT INTO testing_default (id, name) VALUES (1, 'Yasir Arfat');  

-- This will insert with salary = 60000 (explicit value)  
INSERT INTO testing_default (id, name, salary) VALUES (2, 'Yasir Arfat', 60000);  

/*  
    Summary:  
    --------  
    1. We created a table with a DEFAULT value for 'salary' (50000 initially).  
    2. We modified the default salary to 70000 using ALTER TABLE.  
    3. We demonstrated how the DEFAULT value works when no value is specified during insertion.  
*/


---------------------------------------------------------------------------
/*                      Understanding Index Constraint
    Step 1: Creating a Table  
    -------------------------  
    - We create a table 'testing_index' with columns:  
        - 'id' as the primary key,  
        - 'name', 'salary', and 'department_id'.  
*/

CREATE TABLE testing_index (
    id INT PRIMARY KEY,  -- Unique ID for each record  
    name VARCHAR(50),  -- Name of the person  
    salary NUMBER,  -- Salary of the person  
    department_id INT  -- ID of the department the person belongs to  
);

/*  
    Step 2: Creating an INDEX   
    - We create an index 'idx_dept_id' on the 'department_id' column.  
    - This will speed up queries that involve searching, sorting, or filtering based on 'department_id'.  
    - Indexes are particularly useful for large datasets to improve retrieval performance.  
*/

CREATE INDEX idx_dept_id ON testing_index (department_id);  

/*  
    Testing INDEX  
    --------------  
    - After creating the index, queries using the 'department_id' column will execute faster.  
    - This index helps in improving the performance of SELECT queries where we filter or sort by 'department_id'.  
*/

-- Example: Query using department_id will be faster due to the index  
SELECT * FROM testing_index WHERE department_id = 5;  

-- Example: Sorting by department_id will be faster due to the index  
SELECT * FROM testing_index ORDER BY department_id;  

/*  
    Step 3: Dropping the Index  
    --------------------------  
    - If we no longer need the index, we can drop it using the DROP INDEX command.  
    - Dropping an index can improve write performance but may slow down read operations.  
*/

DROP INDEX idx_dept_id;  

/*  
    Summary:  
    --------  
    1. We created a table 'testing_index' with columns for id, name, salary, and department_id.  
    2. We created an index 'idx_dept_id' on the 'department_id' column to speed up queries that use it.  
    3. We demonstrated how the index helps improve the performance of SELECT queries using 'department_id'.  
    4. We showed how to drop the index if it's no longer needed.  
*/

--------------------------------------------------------------------------------

/*  
    Step 1: Creating the 'employee' Table  
    --------------------------------------  
    - We create an 'employee' table with various columns:  
        - 'id' as the primary key,  
        - 'first_name', 'last_name', 'email' (unique), 'phone_number',  
        - 'hire_date' (defaults to current date), 'job_title', 'salary', 'department'.  
*/

CREATE TABLE employee (
    id NUMBER PRIMARY KEY,  -- Employee ID  
    first_name VARCHAR2(50) NOT NULL,  -- Employee first name  
    last_name VARCHAR2(50) NOT NULL,  -- Employee last name  
    email VARCHAR2(100) UNIQUE NOT NULL,  -- Unique email for each employee  
    phone_number VARCHAR2(20),  -- Employee phone number  
    hire_date DATE DEFAULT SYSDATE,  -- Default hire date is the current system date  
    job_title VARCHAR2(100),  -- Job title of the employee  
    salary NUMBER(10, 2),  -- Employee salary  
    department VARCHAR2(50) NOT NULL  -- Department where the employee works  
);

/*  
    Step 2: Inserting Data  
    ----------------------  
    - We insert a new employee record into the 'employee' table.  
    - All the required columns are provided, and the 'hire_date' will default to the current date.  
*/

INSERT INTO employee (id, first_name, last_name, email, 
phone_number, hire_date, job_title, salary, department) 
VALUES (1, 'Yasir', 'Arfat', 'yasir.arfat@nu.edu.pk', 
'123-456-7890', SYSDATE, 'Software Engineer', 75000, 'IT');  

/*  
    Step 3: Viewing the Data  
    ------------------------  
    - We use SELECT to view the data that was inserted into the 'employee' table.  
*/

SELECT * FROM employee;  

/*  
    Step 4: Inserting Another Employee  
    ----------------------------------  
    - We insert another employee with a different ID and details.  
    - Again, the 'hire_date' will default to the current date.  
*/

INSERT INTO employee VALUES 
(2, 'Ali', 'Khan', 'ali.khan@nu.edu.pk', 
'300-123-4567', SYSDATE, 'Software Engineer', 75000, 'IT');  

/*  
    Step 5: Updating an Employee's Information  
    ------------------------------------------  
    - We update the 'job_title' of the employee with ID = 2 to 'HR Manager'.  
    - This demonstrates how to modify existing data in the table.  
*/

UPDATE employee SET job_title = 'HR Manager' WHERE id = 2;  

/*  
    Step 6: Viewing the Updated Data  
    -------------------------------  
    - We use SELECT to check the updated data for the employee with ID = 2.  
*/

SELECT * FROM employee;  

/*  
    Step 7: Deleting an Employee Record  
    -----------------------------------  
    - We delete the record for the employee with ID = 1.  
    - This demonstrates how to remove data from the table.  
*/

DELETE FROM employee WHERE id = 1;  

/*  
    Summary:  
    --------  
    1. We created a table 'employee' with various columns and constraints.  
    2. We inserted two employee records into the table.  
    3. We updated the job title for an employee.  
    4. We deleted a record from the table.  
*/

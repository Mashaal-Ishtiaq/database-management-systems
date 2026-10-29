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
SET SERVEROUTPUT ON;  -- Ensures output is displayed in SQL Developer

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



                     
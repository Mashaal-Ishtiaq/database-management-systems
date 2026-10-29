select * from  locations;
SET SERVEROUTPUT ON;

-- Creating the Stored Procedure
CREATE OR REPLACE PROCEDURE Insert_Data(
    STREET_ADDRESS IN VARCHAR,         
    POSTAL_CODE IN VARCHAR DEFAULT 'NULL',  
    CITY IN VARCHAR,                   
    STATE_PROVINCE IN VARCHAR,          
    COUNTRY_ID IN CHAR                  
)
IS
    Total_record INT;      
    LOCATION_ID NUMBER;    
BEGIN
    -- Get the current count of LOCATION_IDs
    SELECT COUNT(LOCATION_ID) INTO LOCATION_ID FROM LOCATIONS;
    
    -- Increment LOCATION_ID for the new record
    LOCATION_ID := LOCATION_ID + 1;
    Total_record := LOCATION_ID;  -- Store the updated count

    -- Insert new record into the LOCATIONS table
    INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE) 
    VALUES (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE);
END;
/

-- Executing the Stored Procedure
EXEC Insert_Data('Bahria', '1234', 'Lahore', 'SINDH', 'PK');





--------------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Update_Salary(
    p_emp_id IN NUMBER,       -- Employee ID
    p_new_salary IN NUMBER    -- New salary value
)
IS
    v_old_salary NUMBER;      -- Variable to store old salary
BEGIN
    -- Fetch the current salary of the employee
    SELECT salary INTO v_old_salary FROM employees WHERE employee_id = p_emp_id;

    -- Update the employee salary
    UPDATE employees 
    SET salary = p_new_salary 
    WHERE employee_id = p_emp_id;

    -- Display confirmation message
    DBMS_OUTPUT.PUT_LINE('Salary updated from ' || v_old_salary || ' to ' || p_new_salary || ' for Employee ID: ' || p_emp_id);
END;
/

-- EXECUTE EXAMPLE
EXEC Update_Salary(100, 50000);

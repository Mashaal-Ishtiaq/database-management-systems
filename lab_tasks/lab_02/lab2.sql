--select employee_id, first_name, last_name, email, phone_number,  hire_date, JOB_ID
--salary, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID from employees;
--

--select employee_id , phone_number as "contact Number" from EMPLOYEES;

--select first_name  || salary from employees

--select distinct(department_id) from employees;

--select All(salary) from employees;

--select * from departments;

--select first_name , salary from employees where  employee_id=100;

--select * from EMPLOYEES where salary > 1000 and  department_id =100;


--select * from EMPLOYEES where salary BETWEEN 2000 and  3000

--select * from jobs where JOB_TITLE in ('sales Manager', 'Purchasing Manager');

--select * from employees where FIRST_NAME like '%a%';

--select * from employees where last_NAME like '_un%';

--select * from employees where COMMISSION_PCT is not null;

--select * from employees order by salary asc

--select abs(-1) as abs_function from dual

--select greatest(22,34,43) as greatest_function from dual;

--select least(22,34,43) as least_function from dual;

--select ceil(2.11) as ceil_fun from dual;

--select floor(2.11) as floor_fun from dual;

--SELECT TRUNC(123.456, 1) as truncate_function FROM dual;

--SELECT round(123.466, 1) as round_function FROM dual;

--select lower('LoWER FUNCTION IS USED') as lower_function from dual;

--select upper('Upper function is used') as upper_function from dual;

--select initcap('Upper function is used') as inticap_function from dual;

--select ltrim('Yasir Arfat','Yasir') as ltrim_function from dual;

--select rtrim('Yasir Arfat','Arfat') as rtrim_function from dual;


--SELECT TRIM('x' FROM 'xxxHello Worldxxx') AS trimmed_string from dual;

--select SUBSTR('see the use of sbstring',16,8) as substr_function from dual;

--SELECT LENGTH('CANDIDE') AS String_length from dual;

--SELECT lpad('Good',8,'a') as lpad_function from dual;

--SELECT rpad('Good',8,'a') as rpad_function from dual;

--select sysdate as today from dual;

--select add_months(sysdate,9) as date_after_9_months from dual;

--select MONTHS_BETWEEN('16-SEP-25', '16-DEC-21') as months_between_fun from dual;

--select next_day(sysdate, 'Monday') as nextday from dual;

--select last_day(sysdate) as lastday from dual;

--SELECT NEW_TIME(TO_DATE('01-JUN-2023 12:00:00', 'DD-MON-YYYY HH24:MI:SS'), 'PST', 'EST')
--AS new_time FROM dual;

--select to_char(30,'$90') as tocar from  dual;

--select to_char(sysdate,'Day, Month ,  YYYY') as tochar from  dual;

--select to_date('01-jun-08') as toDateFunction from dual;

--select nvl(null,11) as nvl_fun from  dual;

--SELECT DECODE(1, 1, 'One', 2, 2, 3, 'Three', 'Unknown') AS result FROM dual;

--select round(avg(salary)) as average_salaries from employees;

--select max(salary) as maxium_salary from employees;

--select min(salary) as minimum_salary from employees;

--select sum(salary) as total_salaries_sum from employees;
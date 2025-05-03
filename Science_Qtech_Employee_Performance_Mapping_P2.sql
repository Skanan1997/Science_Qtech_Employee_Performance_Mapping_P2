/*1.	Create a database named employee,
 then import data_science_team.csv proj_table.csv 
 and emp_record_table.csv into the employee database 
 from the given resources.*/
 
create database employee;
use employee;
select * from employee.data_science_team;
 
 
 /*2.	Create an ER diagram for the given employee database.
 copy paste in word file
 */
 
 
 
 /* 3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
 and DEPARTMENT from the employee record table, and make a list of employees
 and details of their department. */
 
 
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;


 /* 4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, 
 DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four
 */
 
 select emp_id, first_name, last_name, gender, dept, emp_rating from emp_record_table
 where emp_rating  < 2 
 or emp_rating > 4 
 or (emp_rating between 2 and 4);
 
 
 
 /* 5.	Write a query to concatenate the FIRST_NAME and 
 the LAST_NAME of employees in the Finance department from 
 the employee table and then give the resultant column alias as NAME. */
 
 select concat(first_name,' ',last_name) as NAME
 from emp_record_table where dept = 'finance';
 
 /* 6.	Write a query to list only those employees who have someone reporting to them.
 Also, show the number of reporters (including the President). */
 
SELECT MANAGER_ID, 
       COUNT(EMP_ID) AS NUM_REPORTERS
FROM emp_record_table
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID;

 /* 7.	Write a query to list down all the employees from the healthcare 
 and finance departments using union. Take data from 
 the employee record table. */
 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'Healthcare'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'Finance';
 
 /* 8.	Write a query to list down employee details such as
 EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
 Also include the respective employee rating along with 
 the max emp rating for the department. */
 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, 
ROLE, DEPT, EMP_RATING, 
MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_EMP_RATING
FROM emp_record_table
ORDER BY DEPT, EMP_RATING DESC;
 
 /* 9.	Write a query to calculate the minimum and the maximum salary of 
 the employees in each role. Take data from the employee record table. */
 
SELECT ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE;

 
 /* 10.	Write a query to assign ranks to each employee based on their experience.
 Take data from the employee record table. */
 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, 
ROLE, DEPT, EXP, 
RANK() OVER (ORDER BY EXP DESC) AS EMP_RANK
FROM emp_record_table;

 
 /* 11.	Write a query to create a view that displays employees in various countries
 whose salary is more than six thousand. Take data from the employee record table. */

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;
 
 /* 12.	Write a nested query to find employees with experience of more than ten years.
 Take data from the employee record table. */
 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP
FROM emp_record_table
WHERE EXP > (SELECT 10);
 
 /* 13.	Write a query to create a stored procedure to retrieve the details of the employees
 whose experience is more than three years. Take data from the employee record table. */
 
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP
    FROM emp_record_table
    WHERE EXP > 3;

 /* 14.	Write a query using stored functions in the project table to check whether the job
 profile assigned to each employee in the data science team matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
 */
 
 DELIMITER //

CREATE FUNCTION GetJobProfile(experience INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_profile VARCHAR(50);

    IF experience <= 2 THEN
        SET job_profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF experience > 2 AND experience <= 5 THEN
        SET job_profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF experience > 5 AND experience <= 10 THEN
        SET job_profile = 'SENIOR DATA SCIENTIST';
    ELSEIF experience > 10 AND experience <= 12 THEN
        SET job_profile = 'LEAD DATA SCIENTIST';
    ELSEIF experience > 12 AND experience <= 16 THEN
        SET job_profile = 'MANAGER';
    ELSE
        SET job_profile = 'UNKNOWN';
    END IF;

    RETURN job_profile;
END //

DELIMITER ;

SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    EXP, 
    ROLE AS ASSIGNED_ROLE, 
    GetJobProfile(EXP) AS STANDARD_ROLE,
    IF(ROLE = GetJobProfile(EXP), 'MATCH', 'MISMATCH') AS STATUS
FROM 
    data_science_team;


 
 /* 15.	Create an index to improve the cost and performance of the query to find the 
 employee whose FIRST_NAME is ‘Eric’ in the employee table 
 after checking the execution plan. */
 
 CREATE INDEX idx_first_name 
ON emp_record_table (FIRST_NAME);
 
 EXPLAIN SELECT * 
FROM emp_record_table 
WHERE FIRST_NAME = 'Eric';

 /* 16.	Write a query to calculate the bonus for all the employees,
 based on their ratings and salaries (Use the formula: 5% of salary * employee rating). */
 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING, 
(0.05 * SALARY * EMP_RATING) AS BONUS
FROM emp_record_table;
 
 /* 17.	Write a query to calculate the average salary distribution based on the continent 
 and country. Take data from the employee record table. */
 
SELECT CONTINENT, COUNTRY, 
AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;
    
 
 
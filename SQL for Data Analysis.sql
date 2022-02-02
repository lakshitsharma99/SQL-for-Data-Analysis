/* 
Data Exploration using SQL
    
Tools & Language: MySQL Workbench, SQL
    
SQL topics covered:
→ BASIC SQL QUERIES
→ JOINS
→ SUBQUERIES
→ VIEWS
→ GROUP BY CLAUSE
→ WHERE CLAUSE
→ INDEXES
→ HAVING CLAUSE    
→ ORDER BY CLAUSE
→ STORED PROCEDURES
→ FUNCTIONS
→ AGGREGATION FUNCTIONS
→ CTE
→ WINDOW FUNCTIONS

I'm using 'employees' database for this analysis which contain 7 tables. 

# To find out how many tables this database have, let's run show tables command
mysql> show tables;
+----------------------+
| Tables_in_employees  |
+----------------------+
| departments          |
| dept_emp             |
| dept_manager         |
| emp_manager          |
| employees            |
| salaries             |
| titles               |
+----------------------+

Let' extract some rows of datasets-
mysql> select * from employees limit 5; # employees table
+--------+------------+------------+-----------+--------+------------+
| emp_no | birth_date | first_name | last_name | gender | hire_date  |
+--------+------------+------------+-----------+--------+------------+
|  10001 | 1953-09-02 | Georgi     | Facello   | M      | 1986-06-26 |
|  10002 | 1964-06-02 | Bezalel    | Simmel    | F      | 1985-11-21 |
|  10003 | 1959-12-03 | Parto      | Bamford   | M      | 1986-08-28 |
|  10004 | 1954-05-01 | Chirstian  | Koblick   | M      | 1986-12-01 |
|  10005 | 1955-01-21 | Kyoichi    | Maliniak  | M      | 1989-09-12 |
+--------+------------+------------+-----------+--------+------------+
5 rows in set (0.01 sec)

mysql> select * from salaries limit 5; # salaries table
+--------+--------+------------+------------+
| emp_no | salary | from_date  | to_date    |
+--------+--------+------------+------------+
|  10001 |  60117 | 1986-06-26 | 1987-06-26 |
|  10001 |  62102 | 1987-06-26 | 1988-06-25 |
|  10001 |  66074 | 1988-06-25 | 1989-06-25 |
|  10001 |  66596 | 1989-06-25 | 1990-06-25 |
|  10001 |  66961 | 1990-06-25 | 1991-06-25 |
+--------+--------+------------+------------+
5 rows in set (0.01 sec)

mysql> select * from titles limit 5; # titles table
+--------+-----------------+------------+------------+
| emp_no | title           | from_date  | to_date    |
+--------+-----------------+------------+------------+
|  10001 | Senior Engineer | 1986-06-26 | 9999-01-01 |
|  10002 | Staff           | 1996-08-03 | 9999-01-01 |
|  10003 | Senior Engineer | 1995-12-03 | 9999-01-01 |
|  10004 | Engineer        | 1986-12-01 | 1995-12-01 |
|  10004 | Senior Engineer | 1995-12-01 | 9999-01-01 |
+--------+-----------------+------------+------------+
5 rows in set (0.03 sec)

mysql> select * from emp_manager limit 5; # emp_manager table		
+--------+---------+------------+
| emp_no | dept_no | manager_no |
+--------+---------+------------+
|  10001 | d005    |     110022 |
|  10002 | d007    |     110022 |
|  10003 | d004    |     110022 |
|  10004 | d004    |     110022 |
|  10005 | d003    |     110022 |
+--------+---------+------------+
5 rows in set (0.02 sec)

mysql> select * from dept_manager limit 5; # dept_manager table
+--------+---------+------------+------------+
| emp_no | dept_no | from_date  | to_date    |
+--------+---------+------------+------------+
| 110022 | d001    | 1985-01-01 | 1991-10-01 |
| 110039 | d001    | 1991-10-01 | 9999-01-01 |
| 110085 | d002    | 1985-01-01 | 1989-12-17 |
| 110114 | d002    | 1989-12-17 | 9999-01-01 |
| 110183 | d003    | 1985-01-01 | 1992-03-21 |
+--------+---------+------------+------------+
5 rows in set (0.00 sec)

mysql> select * from dept_emp limit 5; # dept_emp table
+--------+---------+------------+------------+
| emp_no | dept_no | from_date  | to_date    |
+--------+---------+------------+------------+
|  10001 | d005    | 1986-06-26 | 9999-01-01 |
|  10002 | d007    | 1996-08-03 | 9999-01-01 |
|  10003 | d004    | 1995-12-03 | 9999-01-01 |
|  10004 | d004    | 1986-12-01 | 9999-01-01 |
|  10005 | d003    | 1989-09-12 | 9999-01-01 |
+--------+---------+------------+------------+
5 rows in set (0.00 sec)

mysql> select * from departments limit 5; # departments table
+---------+------------------+
| dept_no | dept_name        |
+---------+------------------+
| d009    | Customer Service |
| d005    | Development      |
| d002    | Finance          |
| d003    | Human Resources  |
| d001    | Marketing        |
+---------+------------------+
5 rows in set (0.00 sec)
*/

# Let's run USE statement to select this database in the SQL schema
use employees; 

# Let's try to answer some questions about our data.    

-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch';

-- Select all managers’ first and last name, hire date, job title, start date, and department name.

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
WHERE
    t.title = 'Manager'
ORDER BY d.dept_name , e.first_name;

-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

SELECT 
    e.*
FROM
    employees e
WHERE
    e.hire_date BETWEEN '1990-01-01' AND '1995-01-01'
        AND e.emp_no IN (SELECT 
            d.emp_no
        FROM
            dept_manager d);
            
-- Select the entire information for all employees whose job title is “Assistant Engineer”. 

SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');
                
-- Assign employee number 110022 as a manager to all employees from 10001 to 10020.

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no,
            d.dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no , d.dept_no) AS A;
    
-- Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.

CREATE OR REPLACE VIEW avg_manager_sal AS
    SELECT 
        AVG(s.salary)
    FROM
        salaries s
            JOIN
        dept_manager d ON s.emp_no = d.emp_no;
        
-- Call the View avg_manager_sal

SELECT 
    *
FROM
    avg_manager_sal;

-- Create a procedure that will provide the average salary of all employees

DELIMITER $$
CREATE PROCEDURE avg_sal()
BEGIN
SELECT 
    AVG(salary) as Average_Salary
FROM
    salaries;
END $$
DELIMITER ;

-- Create a procedure called ‘emp_salary_info that uses as parameters the employee ID of an individual, and returns Full Name and their average Salary.

DELIMITER $$
create procedure emp_salary_info(in ID integer, out First_Name varchar(30), out Last_Name varchar(30), out Average_Salary integer)
begin
SELECT 
    e.first_name, e.last_name, AVG(s.salary)
INTO First_Name , Last_Name , Average_Salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = ID;
end $$
DELIMITER ;

-- Call this procedure emp_salary_info
call employees.emp_salary_info(10002, @First_Name, @Last_Name, @Average_Salary);

-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.

DELIMITER $$

CREATE FUNCTION emp_info(First_Name VARCHAR(30), Last_Name VARCHAR(30)) returns DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA

BEGIN
DECLARE new_sal DECIMAL(10,2);
SELECT 
    MAX(s.salary)
INTO new_sal FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = First_Name
        AND e.last_name = Last_Name;
return new_sal;
end $$
DELIMITER ;

-- Call the function emp_info
SELECT emp_info("Georgi", "Facello");

-- Select first name, last name and average salary of people whose average salary is higher than $50,000 per annum.
-- Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    AVG(s.salary) AS avg_sal
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
HAVING AVG(s.salary) > 50000
ORDER BY e.emp_no;
 
 create index fn_ln_en on employees (emp_no, first_name, last_name);
 
select * from dept_manager;
select * from dept_emp;
select * from employees;

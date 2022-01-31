/* 
Data Exploration using SQL
    
Tools & Language: MySQL Workbench, SQL
    
SQL topics covered:
→ BASIC SQL QUERIES
→ JOINS
→ AGGREGATION FUNCTIONS
→ GROUP BY CLAUSE
→ WHERE CLAUSE
→ HAVING CLAUSE    
→ ORDER BY CLAUSE
→ CTE
→ WINDOW FUNCTIONS
→ STORED PROCEDURES
→ FUNCTIONS
→ SUBQUERIES
→ VIEWS
    
I'm using 'employees' database for this analysis which contain 7 tables. 

# To find out how many tables this database have
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

mysql> select * from employees limit 5;
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

mysql> select * from salaries limit 5;
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

mysql> select * from titles limit 5;
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

mysql> select * from emp_manager limit 5;			
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

mysql> select * from dept_manager limit 5;
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

mysql> select * from dept_emp limit 5;
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

mysql> select * from departments limit 5;
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

-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager d ON e.emp_no = d.emp_no;
    
-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. See if the output contains a manager with that name.  

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC;

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
        
-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009';
    
-- Return a list with the first 10 employees with all the departments they can be assigned to.

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no <= 10010
ORDER BY e.emp_no , d.dept_no;

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
    t.title = 'Manager' order by d.dept_name;

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
                
-- Assign employee number 110022 as a manager to all employees from 10001 to 10020, and employee number 110039 as a manager to all employees from 10021 to 10040.

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
    ORDER BY e.emp_no , d.dept_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no,
            d.dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no
    ORDER BY e.emp_no , d.dept_no) AS B;
    
-- Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.

CREATE OR REPLACE VIEW avg_manager_sal AS
    SELECT 
        AVG(s.salary)
    FROM
        salaries s
            JOIN
        dept_manager d ON s.emp_no = d.emp_no;

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

# To execute this procedure
call avg_sal();

delimiter $$
create procedure info(in emp_no_n integer, out res varchar(20))
begin
select first_name into res from employees where emp_no = emp_no_n;
end $$
delimiter ;

drop procedure info;
call info('10002');

select * from employees limit 1;

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.

delimiter $$
create procedure emp_info(in fn varchar(30), out en varchar(30))
begin
select emp_no into en from employees where first_name = fn;
end $$
delimiter ;
drop procedure emp_info;

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)

BEGIN

                SELECT

                                e.emp_no

                INTO p_emp_no FROM

                                employees e

                WHERE

                                e.first_name = p_first_name

                                                AND e.last_name = p_last_name;

END$$

DELIMITER ;





















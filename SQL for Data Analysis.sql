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

-- What is the salary of 'Assistant Engineer', 'Engineer' and 'Senior Engineer'

SELECT 
    t.title, s.salary
FROM
    salaries s
        JOIN
    titles t ON s.emp_no = t.emp_no
WHERE
    t.title IN ('Assistant Engineer' , 'Engineer', 'Senior Engineer')
GROUP BY t.title
ORDER BY t.title; 

-- Create a procedure that take department no. as input and return department name and numbers of employees of that department

DELIMITER $$
CREATE PROCEDURE dept_info(IN Dept_No VARCHAR(10), out Dept_Name VARCHAR(50), out Total_Employees INTEGER)
BEGIN
SELECT 
    d.dept_no, d.dept_name, COUNT(de.dept_no) AS total_employee
    INTO Dept_No, Dept_Name, Total_Employees
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
    where d.dept_no = Dept_no
GROUP BY de.dept_no
ORDER BY d.dept_no;
END $$
DELIMITER ;

-- To execute the procedure dept_info

CALL dept_info('d009', @Dept_Name, @Total_Employees); select @Dept_Name, @Total_Employees;

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
        t.title, ROUND(AVG(s.salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager d ON s.emp_no = d.emp_no
            JOIN
        titles t ON t.emp_no = d.emp_no
    WHERE
        t.title = 'Manager';
        
-- Call the View avg_manager_sal

SELECT 
    *
FROM
    avg_manager_sal;

-- Create a procedure called ‘emp_info that uses as parameters the employee ID of an individual, and returns Full Name, Title and their average Salary.

DELIMITER $$
CREATE PROCEDURE emp_info(IN ID INTEGER, OUT First_Name VARCHAR(30), OUT Last_Name VARCHAR(30), OUT Title VARCHAR(30), OUT Average_Salary INTEGER)
BEGIN
SELECT 
    e.first_name, e.last_name, t.title, AVG(s.salary)
INTO First_Name , Last_Name , Title, Average_Salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
		JOIN
    titles t ON t.emp_no = s.emp_no
WHERE
    e.emp_no = ID;
END $$
DELIMITER ;

-- Call this procedure emp_info
CALL employees.emp_info(10002, @First_Name, @Last_Name, @Title, @Average_Salary);
SELECT @First_Name, @Last_Name, @Title, @Average_Salary;

-- Create a function called ‘salary_info’ that takes for parameters the first and last name of an employee, and returns the salary of that employee.

DELIMITER $$
CREATE FUNCTION salary_info(First_Name VARCHAR(30), Last_Name VARCHAR(30)) returns DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
DECLARE new_sal DECIMAL(10,2);
SELECT 
    AVG(s.salary)
INTO new_sal FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = First_Name
        AND e.last_name = Last_Name;
RETURN new_sal;
END $$
DELIMITER ;

-- Call the function emp_info
SELECT salary_info("Georgi", "Facello");

-- Select first name, last name and average salary of people whose average salary is higher than $50,000 per annum.

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
 
-- Create an index on the ‘emp_no, first_name, last_name’ column of that table, and check if it has sped up the search of the same SELECT statement.
CREATE INDEX fn_ln_en on employees (emp_no, first_name, last_name);

-- Create a VIEW to extract average salary of department manager

CREATE OR REPLACE VIEW avg_manager_sal AS
    SELECT 
        t.title, ROUND(AVG(s.salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager d ON s.emp_no = d.emp_no
            JOIN
        titles t ON t.emp_no = d.emp_no
    WHERE
        t.title = 'Manager';
        
-- Call the View avg_manager_sal

SELECT * FROM avg_manager_sal;

-- Create a VIEW to calculate total employees of all titles

CREATE OR REPLACE VIEW title_info AS
    SELECT 
        t.title, COUNT(e.emp_no) AS total_employees
    FROM
        employees e
            JOIN
        titles t ON e.emp_no = t.emp_no
    GROUP BY t.title
    ORDER BY t.title;

-- Call the View title_info

SELECT * FROM TITLE_INFO;

-- What is salary of employee 10001, 10002 and their titles extract using subqueries

SELECT 
    s.emp_no, ROUND(AVG(s.salary), 2) AS salary, t.title
FROM
    salaries s
        JOIN
    titles t ON s.emp_no = t.emp_no
WHERE
    s.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.emp_no IN ('10001' , '10002'))
GROUP BY s.emp_no;

select * from dept_emp;
select emp_no, count(dept_no) over (partition by dept_no) as ma from dept_emp ; 

select emp_no, max(salary) from salaries group by emp_no;
select * from dept_emp;

select *,
row_number() over(partition by dept_no order by emp_no) row_num,
rank() over(partition by dept_no order by emp_no) row_num,
dense_rank() over(partition by dept_no order by emp_no) row_num
from dept_emp;

select * from employees;

select *,
rank() over(partition by student order by class desc) rnk,
dense_rank() over(partition by student order by class desc  ) drank from courses;
 
 update courses set student='A' where student='G';
 select * from courses;
 
 select e.emp_no, e.first_name, avg(s.salary) from employees e join salaries s on e.emp_no = s.emp_no
 group by e.emp_no having avg(s.salary) > 60000;
 
 select d.dept_name, avg(salary) as sal from
departments d
join dept_emp e on d.dept_no = e.dept_no
join salaries s on e.emp_no = s.emp_no
group by d.dept_no
having sal > 60000;
update salary set salary=3000
 where name = 'B';
select * from salary;
delete from salary
 where id = 0;
insert into salary values(9,'aman','f',1200),(7,'rajat','f',5600);

select * from salary where length(name) - length(replace(name,"a","")) = 2;

select * from scores;
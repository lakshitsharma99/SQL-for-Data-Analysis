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



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
    
    mysql> use employees;
Database changed
mysql> show tables;
+----------------------+
| Tables_in_employees  |
+----------------------+
| departments          |
| departments_dup      |
| dept_emp             |
| dept_manager         |
| emp_manager          |
| employees            |
| salaries             |
| titles               |
+----------------------+
    

*/

use employees; #database

/* 
Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types, HAVING, GROUP BY, SUNQUERIES, INDEXES, VIEWS, 
*/

select * from employees;
select * from salaries;

select e.*, e.first_name, e.last_name, s.salary from employees e left join salaries s on e.emp_no = s.emp_no where e.hire_date = s.from_date order by e.emp_no;

/*Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager d ON e.emp_no = d.emp_no;


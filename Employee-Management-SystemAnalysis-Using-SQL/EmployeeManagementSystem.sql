CREATE DATABASE sola;
USE sola;

CREATE TABLE IF NOT EXISTS employees(
 id INT PRIMARY KEY,
 name VARCHAR(255),
 age INT,
 department_id INT,
 salary INT,
 manager_id INT
 );

CREATE TABLE IF NOT EXISTS departments(
id INT PRIMARY KEY,
name VARCHAR(30));

INSERT INTO employees(id, name, age, department_id, salary, manager_id)
VALUES(1,'John Doe',30,1,60000, NULL), (2,'Jane Smith',40,2, 80000,1), (3,'Emily Davis',25,1,50000,1),(4, 'Mark Brown', 50,3,90000,NULL);

INSERT INTO departments(id, name) 
VALUES (1, 'Sales'),(2, 'HR'),(3, 'Marketing');

SELECT * FROM employees;

SELECT * FROM departments;

-- Find the names and ages of employees who are over 30 years old.
SELECT name, age 
FROM employees
WHERE age>30;

-- Retrieve all details of employees who work in the 'HR' department.
SELECT *
FROM employees e
JOIN departments d ON d.id=e.department_id
WHERE d.name='HR';

SELECT *
FROM employees 
WHERE department_id= (SELECT id FROM departments WHERE name= 'HR');

-- List the top 3 highest-paid employees.
SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 3;

-- Display employees sorted by age in ascending order.
SELECT *
FROM employees
ORDER BY age;

-- Find the total salary paid to employees in each department.
SELECT d.name, SUM(salary) 
FROM employees e
JOIN departments d ON e.id=d.id
GROUP BY 1;

-- Count the number of employees in each department.
SELECT  department_id, COUNT(id) AS num_emp
FROM employees
GROUP BY 1;

-- Find the average age of employees in each department.
SELECT department_id, AVG(age)
FROM employees
GROUP BY 1;

-- List all employees along with their respective department names.

SELECT *
FROM employees e
JOIN departments d
ON d.id=e.department_id;

-- Find all employees who do not have a department assigned.

SELECT e.name 
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;

-- List employees whose salary is above the average salary.
SELECT name, salary
FROM employees
WHERE salary>(SELECT AVG(salary) FROM employees);

-- Find departments that have more than 2 employees.
SELECT department_id, cnt
FROM (SELECT department_id, COUNT(id) AS cnt FROM employees GROUP BY department_id) AS sub
WHERE cnt>=2;

SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>=2;

-- Find employees who are either in 'Sales' or 'HR' departments.
SELECT *
FROM employees e
JOIN departments d ON e.department_id=d.id
WHERE d.name='Sales' OR d.name='HR';

SELECT *
FROM employees
WHERE department_id IN (SELECT id FROM departments WHERE name IN ('Sales', 'HR'));

-- Find employees who are in 'Sales' but not in 'IT'.
SELECT name
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE name='Sales')
EXCEPT
SELECT name
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE name='IT');

-- Find the total salary paid by each department and list only those departments with a total salary greater than 100,000.
WITH total_salary AS (
	SELECT department_id, SUM(salary) as tot_salary
    FROM employees
    GROUP BY 1)
SELECT department_id, tot_salary
FROM total_salary
WHERE tot_salary> 100000; 

-- Find the management hierarchy starting from employees with no managers.
WITH RECURSIVE employee_hierarchy AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;

-- Rank employees by their salary within their department.
SELECT name, department_id, salary, DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rn
FROM employees;

-- Calculate the average salary over all employees and display it alongside each employee's data.
SELECT *, AVG(salary) OVER() AS avg_salary
FROM employees;

-- Insert a new employee into the 'HR' department.
INSERT INTO employees(id, name, age, department_id, salary, manager_id) 
VALUES(7,'Chan Smith', 20,1,40000,1);

-- Update the salary of employees in the 'Sales' department by increasing it by 10%.
UPDATE employees
SET salary=salary*1.10
WHERE department_id IN (SELECT id FROM departments WHERE name='Sales');

-- Delete employees who are older than 60 years.
DELETE FROM employees WHERE age>60;

-- Create a new table to store project information.
 CREATE TABLE IF NOT EXISTS projects(
 id INT PRIMARY KEY,
 department_id INT,
 name VARCHAR(19));
 
 -- Add a column for email addresses to the employees table.
 ALTER TABLE employees ADD COLUMN email_id VARCHAR(50);
 
 -- Remove the manager_id column from the employees table.
 ALTER TABLE employees DROP COLUMN email_id;
 
 -- List employees that are not managers
 SELECT * FROM employees
 WHERE manager_id IS NOT NULL;
 
 -- find the name of managers
 SELECT *
 FROM employees e
 LEFT JOIN employees e2 ON e.id=e2.manager_id;
 
 -- Retrieve a list of employees along with their department names, but only for departments that start with the letter 'S'.
SELECT d.name, e.name
FROM employees e
JOIN departments d
ON e.department_id=d.id
WHERE d.name LIKE '%R';

-- In SQL, the EXPLAIN keyword provides a description of how the SQL queries are executed by the databases. These descriptions include the optimizer logs, how tables are joined and in what order, etc.
-- Hence, it would be a useful tool in query optimization and knowing the details of its execution step by step. The EXPLAIN also indicates the fact that a user who doesn’t
-- have any access to a particular database will not be provided details about how it executes the queries. So it maintains security as well.

EXPLAIN SELECT d.name, e.name
FROM employees e
JOIN departments d
ON e.department_id=d.id
WHERE d.name LIKE '%R';

EXPLAIN SELECT* FROM employees;
ANALYZE TABLE  employees;
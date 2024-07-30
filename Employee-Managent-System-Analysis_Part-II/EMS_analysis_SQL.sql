CREATE DATABASE IF NOT EXISTS Employee_Management_System;
USE Employee_Management_System;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT employee_id, name
FROM employees
WHERE salary>50000;

--  Find the average salary of employees in each department.
SELECT d.department_name, AVG(salary) AS avg_salary
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- List all employees with their department names.
SELECT name, d.department_name
FROM employees e
JOIN  departments d
ON d.department_id = e.department_id;

--  Find all employees who earn more than the average salary of their department.
SELECT name, department_id
FROM employees
WHERE salary> (SELECT AVG(salary)
               FROM employees
			   WHERE employee_id=employees.employee_id);


-- Select all employees and sort them by hire date in descending order.
SELECT name, hire_date
FROM employees
ORDER BY hire_date DESC;

-- Increase the salary of all employees in the 'Sales' department by 10%.
UPDATE employees 
SET salary=salary*1.10
WHERE department_id= (SELECT department_id FROM departments WHERE department_name='Sales');

-- Delete all employees who have not been assigned a department.
DELETE FROM employees
WHERE department_id IS NULL;

-- Insert a new employee into the employees table.
INSERT INTO employees (name, salary, hire_date, department_id) 
VALUES ('Sora Light', 80000,'2024-07-20', 2);

SELECT * FROM employees;

-- Create a table named projects with columns for project ID, name, and start date.
CREATE TABLE projects(
	project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    start_date DATE);
    
--  Categorize employees into 'High', 'Medium', and 'Low' salary bands.

SELECT name, salary, 
	CASE WHEN salary>=80000 THEN 'High'
					 WHEN salary >= 50000 THEN 'Medium'
                     ELSE 'Low'
                     END AS salary_band
FROM employees;

--  Rank employees within their department based on salary.

SELECT name, department_id, salary, RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS SalaryRank
FROM employees;

-- Retrieve the total number of employees in each department.
SELECT d.department_name,COUNT(e.employee_id) AS employee_cnt
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
GROUP BY department_name;

-- Find the department with the highest average salary among its employees.
SELECT department_name, AVG(salary)
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
GROUP BY department_name;

-- List all employees who were hired before 2020 and their department names.
SELECT e.name, department_name
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE hire_date<'2020-01-01';

-- Find the total salary expenditure for each department.
SELECT department_name, SUM(salary) AS salary_exp
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
GROUP BY department_name;

-- Get a list of departments that do not have any employees.
SELECT department_name
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE e.department_id IS NULL;

-- Retrieve a list of employees along with their department names, but only for departments that start with the letter 'S'.
SELECT department_name, e.name
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_name LIKE 'S%';

-- Find all employees and their departments, including employees without departments and departments without employees.
SELECT e.name AS employee_name, d.department_name
FROM employees e
FULL JOIN departments d ON e.department_id = d.department_id


# Employee Management System SQL Queries

## Overview

This repository contains SQL queries for managing and analyzing data in an Employee Management System. The database includes tables for employees and departments, and the queries cover various operations such as data retrieval, updates, and analytics.

## Database Setup

### 1. Create the Database
```sql
CREATE DATABASE IF NOT EXISTS Employee_Management_System;
USE Employee_Management_System;
```

### 2. Basic Data Retrieval
- Retrieve all employee records:
  ```sql
  SELECT * FROM employees;
  ```

- Retrieve all department records:
  ```sql
  SELECT * FROM departments;
  ```

- Get employee names and IDs where salary is greater than $50,000:
  ```sql
  SELECT employee_id, name
  FROM employees
  WHERE salary > 50000;
  ```

### 3. Analytical Queries
- Calculate the average salary per department:
  ```sql
  SELECT d.department_name, AVG(salary) AS avg_salary
  FROM employees e
  JOIN departments d ON d.department_id = e.department_id
  GROUP BY d.department_name
  ORDER BY avg_salary DESC;
  ```

- List all employees with their department names:
  ```sql
  SELECT name, d.department_name
  FROM employees e
  JOIN departments d ON d.department_id = e.department_id;
  ```

- Find employees earning more than the average salary of their department:
  ```sql
  SELECT name, department_id
  FROM employees
  WHERE salary > (SELECT AVG(salary) FROM employees WHERE employee_id = employees.employee_id);
  ```

### 4. Administrative Queries
- Order employees by hire date:
  ```sql
  SELECT name, hire_date
  FROM employees
  ORDER BY hire_date DESC;
  ```

- Increase salary by 10% for employees in the 'Sales' department:
  ```sql
  UPDATE employees 
  SET salary = salary * 1.10
  WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales');
  ```

- Remove employees without assigned departments:
  ```sql
  DELETE FROM employees
  WHERE department_id IS NULL;
  ```

- Add a new employee record:
  ```sql
  INSERT INTO employees (name, salary, hire_date, department_id) 
  VALUES ('Sora Light', 80000, '2024-07-20', 2);
  ```

### 5. Table Creation
- Create a new table for projects:
  ```sql
  CREATE TABLE projects(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255),
    start_date DATE
  );
  ```

### 6. Advanced Queries
- Categorize employees by salary bands:
  ```sql
  SELECT name, salary, 
    CASE WHEN salary >= 80000 THEN 'High'
         WHEN salary >= 50000 THEN 'Medium'
         ELSE 'Low'
    END AS salary_band
  FROM employees;
  ```

- Rank employees by salary within their department:
  ```sql
  SELECT name, department_id, salary, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS SalaryRank
  FROM employees;
  ```

- Count employees in each department:
  ```sql
  SELECT d.department_name, COUNT(e.employee_id) AS employee_count
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  GROUP BY department_name;
  ```

- Department with the highest average salary:
  ```sql
  SELECT department_name, AVG(salary)
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  GROUP BY department_name;
  ```

- Employees hired before 2020 and their departments:
  ```sql
  SELECT e.name, d.department_name
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  WHERE hire_date < '2020-01-01';
  ```

- Total salary expenditure per department:
  ```sql
  SELECT d.department_name, SUM(salary) AS salary_exp
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  GROUP BY d.department_name;
  ```

- Departments without employees:
  ```sql
  SELECT department_name
  FROM departments d
  LEFT JOIN employees e ON d.department_id = e.department_id
  WHERE e.employee_id IS NULL;
  ```

- Employees and departments with names starting with 'S':
  ```sql
  SELECT d.department_name, e.name
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  WHERE d.department_name LIKE 'S%';
  ```

- All employees and their departments, including those without a department:
  ```sql
  SELECT e.name AS employee_name, d.department_name
  FROM employees e
  FULL JOIN departments d ON e.department_id = d.department_id;
  ```


# Employee Management System Analysis

## Overview

This project demonstrates various SQL operations and queries performed on an `employees` and `departments` database. The database includes information about employees, such as their name, age, department, salary, and manager, along with details about the departments.

## Database Schema

### Tables

1. **employees**
   - `id` (INT, Primary Key): Employee ID
   - `name` (VARCHAR): Employee Name
   - `age` (INT): Employee Age
   - `department_id` (INT): Department ID (Foreign Key)
   - `salary` (INT): Employee Salary
   - `manager_id` (INT): Manager ID (Foreign Key, nullable)

2. **departments**
   - `id` (INT, Primary Key): Department ID
   - `name` (VARCHAR): Department Name

### Data Population

Initial data is inserted into the `employees` and `departments` tables as follows:

**employees Table:**
- `(1, 'John Doe', 30, 1, 60000, NULL)`
- `(2, 'Jane Smith', 40, 2, 80000, 1)`
- `(3, 'Emily Davis', 25, 1, 50000, 1)`
- `(4, 'Mark Brown', 50, 3, 90000, NULL)`

**departments Table:**
- `(1, 'Sales')`
- `(2, 'HR')`
- `(3, 'Marketing')`

## Queries and Analysis

### 1. Basic Select Queries
- **Retrieve all employees and departments.**
- **Find employees over the age of 30.**
- **Retrieve details of employees in the 'HR' department.**

### 2. Aggregate Functions and Grouping
- **Total salary by department.**
- **Count of employees in each department.**
- **Average age of employees in each department.**

### 3. Sorting and Ranking
- **List top 3 highest-paid employees.**
- **Rank employees by salary within their department.**

### 4. Hierarchical Queries
- **Find the management hierarchy starting from employees with no managers.**

### 5. Data Modification
- **Insert a new employee into the 'HR' department.**
- **Update salaries of 'Sales' department employees.**
- **Delete employees older than 60 years.**

### 6. Additional Operations
- **Creating and modifying tables.**
- **Listing employees that are not managers.**
- **Finding managers and their subordinates.**
- **Listing employees along with their department names, filtered by department names starting with 'S'.**

### 7. Query Optimization
- **Using `EXPLAIN` to analyze query execution plans.**
- **Analyzing the `employees` table for optimization insights.**

## Tools Used

- SQL
- Database Management Systems

## How to Use

1. Clone the repository.
2. Set up the database using the provided schema.
3. Execute the SQL queries for analysis and insights.

## Contributing

Feel free to submit issues or pull requests for improvements or new features.


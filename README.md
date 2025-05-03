# Science_Qtech_Employee_Performance_Mapping_P2


## Project Overview

**Project Title**: ScienceQtech Employee Performance Mapping
**Level**: Intermediate
**Database**: ScienceQtech\_Employee\_Performance\_SQL\_Project

This project is designed to showcase SQL skills through a real-world scenario of analyzing employee performance data for a company named ScienceQtech. The objective is to create and manage a database that holds employee information, track their performance, identify top performers, and generate insights that can support managerial decisions such as promotions, trainings, and appraisals.

## Objectives

* **Database Creation**: Set up a structured database to store employee data and performance records.
* **Data Cleaning**: Identify and clean any inconsistencies or missing information in the employee dataset.
* **Exploratory Data Analysis (EDA)**: Understand workforce distribution, roles, departments, and performance levels.
* **Performance Insights**: Generate SQL-based insights to evaluate and improve organizational performance strategies.

## Project Structure

### 1. Database Setup

**Database Creation**:

```sql
CREATE DATABASE ScienceQtech_Employee_Performance_SQL_Project;
```

**Table Creation**:
A table named `employee_performance` is created with fields for employee ID, name, age, gender, department, role, hire date, performance rating, number of projects, and average project score.

```sql
CREATE TABLE employee_performance (
    employee_id INT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    department VARCHAR(50),
    role VARCHAR(50),
    hire_date DATE,
    performance_rating FLOAT,
    projects_handled INT,
    avg_project_score FLOAT
);
```

### 2. Data Exploration & Cleaning

**Total Records**:

```sql
SELECT COUNT(*) FROM employee_performance;
```

**Null Check**:

```sql
SELECT * FROM employee_performance
WHERE employee_id IS NULL OR name IS NULL OR age IS NULL 
OR gender IS NULL OR department IS NULL OR role IS NULL 
OR hire_date IS NULL OR performance_rating IS NULL 
OR projects_handled IS NULL OR avg_project_score IS NULL;
```

**Remove Nulls**:

```sql
DELETE FROM employee_performance
WHERE employee_id IS NULL OR name IS NULL OR age IS NULL 
OR gender IS NULL OR department IS NULL OR role IS NULL 
OR hire_date IS NULL OR performance_rating IS NULL 
OR projects_handled IS NULL OR avg_project_score IS NULL;
```

**Unique Roles and Departments**:

```sql
SELECT DISTINCT role FROM employee_performance;
SELECT DISTINCT department FROM employee_performance;
```

### 3. Data Analysis & Insights

**1. Top 5 performers based on performance rating**:

```sql
SELECT * FROM employee_performance
ORDER BY performance_rating DESC
LIMIT 5;
```

**2. Average performance rating by department**:

```sql
SELECT department, ROUND(AVG(performance_rating), 2) AS avg_rating
FROM employee_performance
GROUP BY department;
```

**3. Employees with more than 10 projects and high average project scores (>85)**:

```sql
SELECT * FROM employee_performance
WHERE projects_handled > 10 AND avg_project_score > 85;
```

**4. Distribution of employees by gender and department**:

```sql
SELECT department, gender, COUNT(*) AS total_employees
FROM employee_performance
GROUP BY department, gender;
```

**5. Number of employees hired each year**:

```sql
SELECT EXTRACT(YEAR FROM hire_date) AS year, COUNT(*) AS hires
FROM employee_performance
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY year;
```

**6. Identify employees eligible for promotion (criteria: performance\_rating > 4.5 AND projects\_handled > 8)**:

```sql
SELECT * FROM employee_performance
WHERE performance_rating > 4.5 AND projects_handled > 8;
```

**7. Average age by role**:

```sql
SELECT role, ROUND(AVG(age), 1) AS avg_age
FROM employee_performance
GROUP BY role;
```

**8. Create performance bands (High: >4.5, Medium: 3-4.5, Low: <3)**:

```sql
SELECT *,
    CASE 
        WHEN performance_rating > 4.5 THEN 'High'
        WHEN performance_rating BETWEEN 3 AND 4.5 THEN 'Medium'
        ELSE 'Low'
    END AS performance_band
FROM employee_performance;
```

## Findings

* **Top Talent**: The top 5 employees have performance ratings above 4.8 with exceptional project scores.
* **Department Performance**: Technical and R\&D departments have the highest average ratings.
* **Workforce Composition**: Balanced gender representation in most departments, with minor skew in technical roles.
* **Hiring Trends**: Hiring peaked in 2021, with a notable dip in 2023.
* **Promotion Candidates**: Several employees qualify for promotions based on consistent high performance.

## Reports

* **Performance Dashboard**: Department-wise performance trends, top performers, and average scores.
* **HR Insights**: Hiring patterns, role distribution, and potential candidates for training/promotion.
* **Employee Distribution**: Breakdown by age, gender, and department.

## Conclusion

This project effectively demonstrates the use of SQL for employee data analysis in a corporate environment. From database creation to deriving business insights, the analysis equips HR and management with actionable insights for strategic decisions like hiring, promotion, and training.

Author - Kanan Sangeet

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

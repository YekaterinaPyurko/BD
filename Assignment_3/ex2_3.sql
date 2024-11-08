-- Drop existing tables if they exist
DROP TABLE IF EXISTS employee_projects CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    budget NUMERIC(10, 2)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    department_id INT,
    hourly_rate NUMERIC(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    department_id INT,
    total_hours_allocated INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create employee_projects table
CREATE TABLE employee_projects (
    employee_project_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    hours_worked INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Insert sample data into departments
INSERT INTO departments (department_id, budget) VALUES
(1, 1000),   -- Budget is low to ensure it can be exceeded
(2, 5000),
(3, 6000);

-- Insert sample data into employees
INSERT INTO employees (employee_id, department_id, hourly_rate) VALUES
(1, 1, 50.00),  -- High hourly rate
(2, 1, 30.00),
(3, 2, 20.00),
(4, 2, 40.00),
(5, 3, 15.00);

-- Insert sample data into projects
INSERT INTO projects (project_id, department_id, total_hours_allocated) VALUES
(1, 1, 500),    -- Project in department 1 with low budget
(2, 2, 1000),
(3, 3, 1500);

-- Insert sample data into employee_projects
INSERT INTO employee_projects (employee_project_id, employee_id, project_id, hours_worked) VALUES
(1, 1, 1, 20),   -- This will exceed the budget
(2, 2, 1, 30),   -- Total cost for project 1 will exceed the budget
(3, 3, 2, 200),
(4, 4, 2, 100),
(5, 5, 3, 400);

-- Query to identify projects where the total hours worked multiplied by the hourly rate exceeds the department budget
SELECT 
    p.project_id,
    d.budget AS department_budget,
    SUM(ep.hours_worked * e.hourly_rate) AS total_cost
FROM 
    projects p
JOIN 
    departments d ON p.department_id = d.department_id
JOIN 
    employee_projects ep ON p.project_id = ep.project_id
JOIN 
    employees e ON ep.employee_id = e.employee_id
GROUP BY 
    p.project_id, d.budget
HAVING 
    SUM(ep.hours_worked * e.hourly_rate) > d.budget;




WITH EmployeeHours AS (
    SELECT 
        ep.employee_id,
        SUM(ep.hours_worked) AS total_hours,
        COUNT(DISTINCT DATE_TRUNC('week', CURRENT_DATE - INTERVAL '1 month' + (n * INTERVAL '1 week'))) AS weeks_count
    FROM 
        employee_projects ep
    JOIN 
        projects pr ON ep.project_id = pr.project_id
    CROSS JOIN 
        generate_series(0, 3) AS n -- This generates the last 4 weeks
    WHERE 
        ep.hours_worked IS NOT NULL
        AND ep.hours_worked > 0
        AND pr.department_id IS NOT NULL
        AND ep.hours_worked > 0
        AND ep.hours_worked IS NOT NULL
        AND ep.hours_worked > 0
    GROUP BY 
        ep.employee_id
)
SELECT 
    e.employee_id,
    SUM(eh.total_hours) AS total_hours,
    (SUM(eh.total_hours)::numeric / NULLIF(SUM(eh.weeks_count), 0)) AS average_weekly_hours
FROM 
    EmployeeHours eh
JOIN 
    employees e ON eh.employee_id = e.employee_id
GROUP BY 
    e.employee_id
HAVING 
    (SUM(eh.total_hours)::numeric / NULLIF(SUM(eh.weeks_count), 0)) > 40;




WITH DepartmentCosts AS (
    SELECT 
        d.department_id,
        DATE_TRUNC('quarter', ep.hours_worked) AS quarter,
        SUM(ep.hours_worked * e.hourly_rate) AS total_cost
    FROM 
        employee_projects ep
    JOIN 
        employees e ON ep.employee_id = e.employee_id
    JOIN 
        departments d ON e.department_id = d.department_id
    GROUP BY 
        d.department_id, quarter
)
SELECT 
    dc.department_id,
    dc.quarter,
    dc.total_cost,
    d.budget
FROM 
    DepartmentCosts dc
JOIN 
    departments d ON dc.department_id = d.department_id
WHERE 
    dc.total_cost > d.budget
ORDER BY 
    dc.department_id, dc.quarter;



WITH DepartmentCosts AS (
    SELECT 
        d.department_id,
        EXTRACT(YEAR FROM CURRENT_DATE) AS year,
        EXTRACT(QUARTER FROM CURRENT_DATE) AS quarter,
        SUM(ep.hours_worked * e.hourly_rate) AS total_cost
    FROM 
        employee_projects ep
    JOIN 
        employees e ON ep.employee_id = e.employee_id
    JOIN 
        departments d ON e.department_id = d.department_id
    GROUP BY 
        d.department_id
)
SELECT 
    dc.department_id,
    dc.year,
    dc.quarter,
    dc.total_cost,
    d.budget
FROM 
    DepartmentCosts dc
JOIN 
    departments d ON dc.department_id = d.department_id
WHERE 
    dc.total_cost > d.budget
ORDER BY 
    dc.department_id;

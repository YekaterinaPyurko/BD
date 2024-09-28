CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    salary INTEGER NOT NULL,
    department_id INTEGER NOT NULL
);


INSERT INTO employees VALUES (1, 50000, 1);
INSERT INTO employees VALUES (2, 60000, 2);
INSERT INTO employees VALUES (3, 70000, 1);
INSERT INTO employees VALUES (4, 80000, 3);
INSERT INTO employees VALUES (5, 55000, 2);


CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT NOT NULL
);


INSERT INTO departments VALUES (1, 'HR');
INSERT INTO departments VALUES (2, 'Engineering');
INSERT INTO departments VALUES (3, 'Finance');



SELECT d.department_name, AVG(e.salary) AS average_salary
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

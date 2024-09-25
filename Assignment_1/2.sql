CREATE TABLE employee_salary (
employee_id INTEGER PRIMARY KEY,
department_id INTEGER NOT NULL,
salary INTEGER NOT NULL
);

INSERT INTO employee_salary VALUES (1, 7, 10000);
INSERT INTO employee_salary VALUES (2,4, 5000);
INSERT INTO employee_salary VALUES (3, 2, 3000);
INSERT INTO employee_salary VALUES (4, 9, 13000);
INSERT INTO employee_salary VALUES (5, 5, 9000);

SELECT * FROM employee_salary;

SELECT department_id, AVG(salary) AS average_salary
FROM employee_salary
GROUP BY department_id
ORDER BY average_salary DESC;

SELECT * FROM employee_salary;

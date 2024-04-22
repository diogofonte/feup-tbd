-- crows foot notation?!

--a
SELECT department_name , COUNT(employee_id) as Employees FROM
EMPLOYEES
JOIN departments on departments.department_id = employees.department_id
GROUP BY department_name;

--b
SELECT department_name, job_title, COUNT(employee_id) as Employees FROM
EMPLOYEES
JOIN departments on departments.department_id = employees.department_id
JOIN jobs on jobs.job_id = employees.job_id
GROUP BY department_name, job_title;


--c
SELECT department_name, MAX(salary) as BestPaid  FROM
EMPLOYEES
JOIN departments on departments.department_id = employees.department_id
GROUP BY department_name;

--d

SELECT first_name, last_name, (end_date - start_date) as JobDuration FROM 
employees
JOIN job_history on job_history.employee_id = employees.employee_id
ORDER BY JobDuration DESC;

--e
SELECT country_name, ROUND(AVG(salary),2) as AverageSalary FROM 
employees
JOIN departments on departments.department_id = employees.department_id
JOIN locations on locations.location_id = departments.location_id
JOIN countries on countries.country_id = locations.country_id
GROUP BY country_name;




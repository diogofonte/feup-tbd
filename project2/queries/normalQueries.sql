-- crows foot notation?!

--a
SELECT department_name , COUNT(employee_id) as Employees FROM
DBO_EMPLOYEES
JOIN DBO_DEPARTMENTS on DBO_DEPARTMENTS.department_id = DBO_EMPLOYEES.department_id
GROUP BY department_name;

--b
SELECT department_name, job_title, COUNT(employee_id) as Employees FROM
DBO_EMPLOYEES
JOIN DBO_DEPARTMENTS on DBO_DEPARTMENTS.department_id = DBO_EMPLOYEES.department_id
JOIN DBO_JOBS on DBO_JOBS.job_id = DBO_EMPLOYEES.job_id
GROUP BY department_name, job_title;


--c
SELECT department_name, MAX(salary) as BestPaid  FROM
DBO_EMPLOYEES
JOIN DBO_DEPARTMENTS on DBO_DEPARTMENTS.department_id = DBO_EMPLOYEES.department_id
GROUP BY department_name;

--d

SELECT first_name, last_name, (end_date - start_date) as JobDuration FROM 
DBO_EMPLOYEES
JOIN DBO_JOB_HISTORY on DBO_JOB_HISTORY.employee_id = DBO_EMPLOYEES.employee_id
ORDER BY JobDuration DESC;

--e
SELECT country_name, ROUND(AVG(salary),2) as AverageSalary FROM 
DBO_EMPLOYEES
JOIN DBO_DEPARTMENTS on DBO_DEPARTMENTS.department_id = DBO_EMPLOYEES.department_id
JOIN DBO_LOCATIONS on DBO_LOCATIONS.location_id = DBO_DEPARTMENTS.location_id
JOIN DBO_COUNTRIES on DBO_COUNTRIES.country_id = DBO_LOCATIONS.country_id
GROUP BY country_name;




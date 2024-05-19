--a
SELECT d.department_name, 
       (SELECT COUNT(*)
        FROM TABLE(d.department_employees)) AS total_employees
FROM dw_departments d;

--b
SELECT d.department_name, e.job.job_title AS JOB_title, COUNT(e.employee_id) AS total_employees
FROM dw_departments d
JOIN dw_employees e ON e.department = REF(d)
GROUP BY d.department_name, e.job.job_title;


--c
SELECT d.department_name, e.employee_id, e.first_name, e.last_name, e.salary
FROM dw_employees e
LEFT JOIN dw_departments d ON e.department = REF(d)
WHERE (e.salary, e.department) IN (
    SELECT MAX(e2.salary), e2.department
    FROM dw_employees e2
    GROUP BY e2.department
);


--d
SELECT e.first_name, e.last_name, SUM(j.end_date - j.start_date) AS JobDuration
FROM dw_employees e
JOIN dw_jobhistories j on j.employee = REF(e)
GROUP BY e.first_name, e.last_name
ORDER BY JobDuration DESC;


--e
SELECT c.country_name, ROUND(AVG(e.salary),2) AS average_salary
FROM dw_employees e
JOIN dw_departments d ON e.department = REF(d)
JOIN dw_locations l ON d.location = REF(l)
JOIN dw_countries c ON l.country = REF(c)
GROUP BY c.country_name;

--f
SELECT d.location.city as Department_City, SUM((SELECT COUNT(*) FROM TABLE(d.department_employees))) AS total_employees
FROM dw_departments d
GROUP BY d.location.city;
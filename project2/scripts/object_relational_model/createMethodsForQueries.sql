-- A) Calculate the total number of employees that each department has got
CREATE OR REPLACE FUNCTION get_total_employees_per_department RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT d.department_name, COUNT(e.employee_id) AS total_employees
    FROM dw_departments d
    LEFT JOIN TABLE(d.department_employees) e
    GROUP BY d.department_name;
    RETURN v_cursor;
END;
/


-- B) In each department, how many employees are there for each job title?
CREATE OR REPLACE FUNCTION get_employees_per_job_title RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT d.department_name, j.job_title, COUNT(e.employee_id) AS total_employees
    FROM dw_departments d
    LEFT JOIN TABLE(d.department_employees) e
    LEFT JOIN dw_jobs j ON e.job = REF(j)
    GROUP BY d.department_name, j.job_title;
    RETURN v_cursor;
END;
/

-- C) Indicate the best paid employee in each department
CREATE OR REPLACE FUNCTION get_best_paid_employee_per_department RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT d.department_name, e.employee_id, e.first_name, e.last_name, e.salary
    FROM dw_employees e
    LEFT JOIN dw_departments d ON e.department = REF(d)
    WHERE (e.salary, e.department) IN (
        SELECT MAX(e2.salary), e2.department
        FROM dw_employees e2
        GROUP BY e2.department
    )
    ORDER BY d.department_name;
    RETURN v_cursor;
END;
/


-- D) Check whether the job history has time gaps for each employee. Sort the employees by job duration on the current day
CREATE OR REPLACE FUNCTION check_job_history_gaps RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT e.employee_id, e.first_name, e.last_name, SUM(NVL((jh.end_date - jh.start_date), 0)) AS job_duration
    FROM dw_employees e
    LEFT JOIN TABLE(e.employee_jobHistories) jh
    GROUP BY e.employee_id, e.first_name, e.last_name
    HAVING COUNT(*) > 0
    ORDER BY job_duration DESC;
    RETURN v_cursor;
END;
/


-- E) Compare the average salary by country
CREATE OR REPLACE FUNCTION compare_average_salary_by_country RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT c.country_name, AVG(e.salary) AS average_salary
    FROM dw_employees e
    JOIN dw_departments d ON e.department = REF(d)
    JOIN dw_locations l ON d.location = REF(l)
    JOIN dw_countries c ON l.country = REF(c)
    GROUP BY c.country_name;
    RETURN v_cursor;
END;
/

-- F) Add a query that illustrates the use of OR extensions
CREATE OR REPLACE FUNCTION get_department_details (
    p_department_id IN NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT d.department_name, e.employee_id, e.first_name, e.last_name, jh.start_date, jh.end_date, j.job_title
    FROM dw_departments d
    LEFT JOIN TABLE(d.department_employees) e
    LEFT JOIN TABLE(e.employee_jobHistories) jh
    LEFT JOIN dw_jobs j ON jh.job = REF(j)
    WHERE d.department_id = p_department_id;
    RETURN v_cursor;
END;
/
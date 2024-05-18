--Populate dw Regions
insert into dw_regions (region_id, region_name)
select region_id, region_name
from dbo_regions;

--Populate dw Countries
INSERT INTO dw_countries (country_id, country_name, region)
SELECT
    c.country_id,
    c.country_name,
    (SELECT REF(r) FROM dw_regions r WHERE r.region_id = c.region_id) 
FROM
    dbo_countries c;

--Populate dw Locations
INSERT INTO dw_locations (location_id, street_address, postal_code, city, state_province, country)
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    l.state_province,
    (SELECT REF(c) FROM dw_countries c WHERE c.country_id = l.country_id) 
FROM
    dbo_locations l;


--Populate dw jobs
INSERT INTO dw_jobs (job_id, job_title, min_salary, max_salary)
SELECT
    j.job_id,
    j.job_title,
    j.min_salary,
    j.max_salary
FROM 
    dbo_jobs j;
-- missing nested tables



--Populate dw departments
INSERT INTO dw_departments (department_id, department_name, location)
SELECT
    d.department_id,
    d.department_name,
    (SELECT REF(l) FROM dw_locations l WHERE l.location_id = d.location_id)
FROM
   dbo_departments d;
--missing nested table, needs employee creation;



--Populate dw employees
INSERT INTO dw_employees(employee_id, first_name, last_name, email, phone_number, hire_date, salary, commission_pct, job, department)
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.phone_number,
    e.hire_date,
    e.salary,
    e.commission_pct,
    (SELECT REF(j) FROM dw_jobs j WHERE j.job_id = e.job_id),
    (SELECT REF(d) FROM dw_departments d WHERE d.department_id = e.department_id)
FROM
    dbo_employees e;
--missing nested table;


-- inserts manager into employee
UPDATE dw_employees de
    SET manager = ( SELECT REF(m) FROM dw_employees m WHERE m.employee_id = 
    ( SELECT e.manager_id FROM dbo_employees e WHERE e.employee_id = de.employee_id));

-- inserts manager into department
UPDATE dw_departments de
    SET manager = (SELECT REF (e) FROM dw_employees e WHERE e.employee_id = 
    (SELECT b.manager_id FROM dbo_departments b WHERE b.department_id = de.department_id));





--Populate dw job histories
INSERT INTO dw_jobhistories (employee, start_date, end_date, job, department)
SELECT
    (SELECT REF(e) FROM dw_employees e WHERE e.employee_id = h.employee_id),
    h.start_date,
    h.end_date,
    (SELECT REF(j) FROM dw_jobs j WHERE j.job_id = h.job_id),
    (SELECT REF(d) FROM dw_departments d WHERE d.department_id = h.department_id)
FROM 
   dbo_job_history h;



--Nested table job_employees for dw jobs
UPDATE dw_jobs j
SET j.job_employees = CAST(MULTISET(
    SELECT REF(e)
    FROM dw_employees e
    WHERE REF(j) = e.job) AS job_employees_tab_t);

--Nested table job histories for dw jobs
UPDATE dw_jobs j
SET j.job_jobHistories = CAST(MULTISET(
    SELECT REF(h)
    FROM dw_jobHistories h
    WHERE REF(j) = h.job) AS job_jobHistories_tab_t);


--Neste table for job histories for de employees
UPDATE dw_employees e
SET e.employee_jobHistories = CAST(MULTISET(
    SELECT REF(h)
    FROM dw_jobHistories h
    WHERE REF(e) = h.employee) AS employee_jobHistories_tab_t);


--Nested table department_employees for dw departments
UPDATE dw_departments d
SET d.department_employees = CAST(MULTISET(
    SELECT REF(e)
    FROM dw_employees e
    WHERE REF(d) = e.department) AS department_employees_tab_t);
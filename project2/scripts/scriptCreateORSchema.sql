CREATE TYPE region_t AS OBJECT (
    region_id NUMBER,
    region_name VARCHAR2(25)
);
CREATE TABLE dw_regions of region_t;


CREATE TYPE country_t AS OBJECT (
    country_id CHAR(2),
    country_name VARCHAR2(40),
    region REF region_t
);
CREATE TABLE dw_countries of country_t;


CREATE TYPE location_t AS OBJECT (
    location_id NUMBER(4),
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30),
    state_province VARCHAR2(25),
    country REF country_t
);
CREATE TABLE dw_locations of location_t;

----------------------------------------

CREATE TYPE job_t AS OBJECT (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6)
);
CREATE TABLE dw_jobs of job_t;


CREATE TYPE department_t AS OBJECT (
    department_id NUMBER(4),
    department_name VARCHAR2(30),
    location REF location_t
); -- add atribute manager and create table after employee_t creation


CREATE TYPE employee_t AS OBJECT (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    email VARCHAR2(25),
    phone_number VARCHAR2(20),
    hire_date DATE,
    salary NUMBER(8,2),
    commision_pct NUMBER(2,2),
    job REF job_t
    --department REF department_t
); -- add atribute for direct manager after employee_t creation


ALTER TYPE employee_t ADD ATTRIBUTE manager REF employee_t CASCADE;

ALTER TYPE department_t ADD ATTRIBUTE manager REF employee_t CASCADE;

-- nested table to have list of employees in each department
CREATE TYPE department_employees_tab_t AS TABLE OF employee_t;
ALTER TYPE department_t ADD ATTRIBUTE department_employees department_employees_tab_t CASCADE;
CREATE TABLE dw_departments OF department_t
    NESTED TABLE department_employees STORE AS department_employees_tab;

-- simple table of employees with department_id
--CREATE TABLE employees of employee_t;

------------------------------------

CREATE TYPE jobHistory_t AS OBJECT (
    department department_t,
    employee employee_t,
    job job_t,
    start_date DATE,
    end_date DATE
);
-- Verify what's wrong with this table of job histories
CREATE TABLE dw_jobHistories OF jobHistory_t;
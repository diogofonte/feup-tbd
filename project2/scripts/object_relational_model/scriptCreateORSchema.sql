CREATE TYPE region_t AS OBJECT (
    region_id NUMBER,
    region_name VARCHAR2(25)
);

CREATE TYPE country_t AS OBJECT (
    country_id CHAR(2),
    country_name VARCHAR2(40),
    region REF region_t
);

CREATE TYPE location_t AS OBJECT (
    location_id NUMBER(4),
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30),
    state_province VARCHAR2(25),
    country REF country_t
); -- create table after Department creation

----------------------------------------

CREATE TYPE job_t AS OBJECT (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6)
);


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
    commission_pct NUMBER(2,2),
    job REF job_t,
    department REF department_t
); -- add atribute for direct manager after employee_t creation


ALTER TYPE employee_t ADD ATTRIBUTE manager REF employee_t CASCADE;
ALTER TYPE department_t ADD ATTRIBUTE manager REF employee_t CASCADE;

-----------------------

-- Department table

-- nested table to have list of employees in each department
CREATE TYPE department_employees_tab_t AS TABLE OF REF employee_t;
ALTER TYPE department_t ADD ATTRIBUTE department_employees department_employees_tab_t CASCADE;

CREATE TYPE jobHistory_t AS OBJECT (
    employee REF employee_t,
    start_date DATE,
    end_date DATE
);


CREATE TABLE dw_departments OF department_t(
    department_id PRIMARY KEY,
    department_name NOT NULL,
    location NULL,
    manager NULL
) NESTED TABLE department_employees STORE AS department_employees_tab;


-- Employee table

-- nested table to have list of job histories for each employee
CREATE TYPE employee_jobHistories_tab_t AS TABLE OF REF jobHistory_t;
ALTER TYPE employee_t ADD ATTRIBUTE employee_jobHistories employee_jobHistories_tab_t CASCADE;

CREATE TABLE dw_employees OF employee_t(
    employee_id PRIMARY KEY,
    first_name NULL,
    last_name NULL,
    email NULL,
    phone_number NULL,
    hire_date NULL,
    salary NULL,
    commission_pct NULL,
    job NULL,
    department NULL,
    manager NULL
) NESTED TABLE employee_jobHistories STORE AS employee_jobHistories_tab; 

-- Job table

-- nested table to have list of employees in each job
CREATE TYPE job_employees_tab_t AS TABLE OF REF employee_t;
ALTER TYPE job_t ADD ATTRIBUTE job_employees job_employees_tab_t CASCADE;

-- nested table to have list of Job Histories in each job
CREATE TYPE job_jobHistories_tab_t AS TABLE OF REF jobHistory_t;
ALTER TYPE job_t ADD ATTRIBUTE job_jobHistories job_jobHistories_tab_t CASCADE;

CREATE TABLE dw_jobs OF job_t(
    job_id PRIMARY KEY,
    job_title NOT NULL,
    min_salary NOT NULL,
    max_salary NOT NULL
) NESTED TABLE job_employees STORE AS job_employees_tab
    NESTED TABLE job_jobHistories STORE AS job_jobHistories_tab;

------------------------------------


ALTER TYPE jobHistory_t ADD ATTRIBUTE job REF job_t CASCADE;
ALTER TYPE jobHistory_t ADD ATTRIBUTE department REF department_t CASCADE;

CREATE TABLE dw_jobHistories OF jobHistory_t(
    employee NULL,
    job NULL,
    department NULL,
    start_date NULL,
    end_date NULL
);

----------------------------------

-- Location table

CREATE TABLE dw_locations of location_t(
    location_id PRIMARY KEY,
    street_address NULL,
    postal_code NULL,
    city NULL,
    state_province NULL,
    country NULL
);


-- Country table

CREATE TABLE dw_countries of country_t(
    country_id PRIMARY KEY,
    country_name NULL,
    region NULL
); 


-- Region table

CREATE TABLE dw_regions of region_t(
    region_id PRIMARY KEY,
    region_name NULL
);
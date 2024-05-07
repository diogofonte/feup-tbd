CREATE OR REPLACE TYPE region_t AS OBJECT (
    region_id NUMBER,
    region_name VARCHAR2(25)
);
CREATE TABLE regions of region_t;


CREATE OR REPLACE TYPE country_t AS OBJECT (
    country_id CHAR(2),
    country_name VARCHAR2(40),
    region REF region_t
);
CREATE TABLE countries of country_t;


CREATE OR REPLACE TYPE location_t AS OBJECT (
    location_id NUMBER(4),
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30),
    state_province VARCHAR2(25),
    country REF country_t
);
CREATE TABLE locations of location_t;

----------------------------------------

CREATE OR REPLACE TYPE job_t AS OBJECT (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6)
);
CREATE TABLE jobs of job_t;


CREATE OR REPLACE TYPE department_t AS OBJECT (
    department_id NUMBER(4),
    department_name VARCHAR2(30),
    location REF location_t
); -- add atribute manager and create table after employee_t creation


CREATE OR REPLACE TYPE employee_t AS OBJECT (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    email VARCHAR2(25),
    phone_number VARCHAR2(20),
    hire_date DATE,
    salary NUMBER(8,2),
    commision_pct NUMBER(2,2),
    job REF job_t,
    department REF department_t
); -- add atribute for direct manager after employee_t creation


ALTER TYPE employee_t ADD ATTRIBUTE manager REF employee_t CASCADE;
ALTER TYPE department_t ADD ATTRIBUTE manager REF employee_t CASCADE;

CREATE TABLE employees of employee_t;
CREATE TABLE departments of department_t;

------------------------------------

CREATE OR REPLACE TYPE jobHistory_t AS OBJECT (
    department department_t,
    employee employee_t,
    job job_t,
    start_date DATE,
    end_date DATE
);
CREATE OR REPLACE TYPE jobHistory_tab_t as table of ref jobHistory_t;
CREATE TABLE jobHistories of jobHistory_t;

--CREATE TABLE jobHistories of jobHistory_t
    --NESTED TABLE docente_dsd store as docente_dsd_tab;
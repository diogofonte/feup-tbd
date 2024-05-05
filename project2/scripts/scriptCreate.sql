CREATE TABLE departments AS SELECT * FROM GTD10.departments;

CREATE TABLE job_history AS SELECT * FROM GTD10.job_history;

CREATE TABLE jobs AS SELECT * FROM GTD10.jobs;

CREATE TABLE employees AS SELECT * FROM GTD10.employees;

CREATE TABLE locations AS SELECT * FROM GTD10.locations;

CREATE TABLE countries AS SELECT * FROM GTD10.countries;

CREATE TABLE regions AS SELECT * FROM GTD10.regions;


--drop all tables

DECLARE
  v_sql VARCHAR2(1000);
BEGIN
  FOR t IN (SELECT table_name FROM user_tables) LOOP
    v_sql := 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE v_sql;
  END LOOP;
END;
/

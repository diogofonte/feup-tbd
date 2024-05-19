-- Method to Calculate the Job Duration
CREATE OR REPLACE TYPE BODY jobHistory_t AS
  MEMBER FUNCTION job_duration RETURN NUMBER IS
  BEGIN
    RETURN end_date - start_date;
  END job_duration;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Check for Time Gaps in Job History
CREATE OR REPLACE TYPE BODY employee_t AS
  MEMBER FUNCTION has_job_history_gaps RETURN VARCHAR2 IS
    prev_end_date DATE := NULL;
    gap_found VARCHAR2(5) := 'FALSE';
  BEGIN
    FOR i IN 1..SELF.employee_jobHistories.COUNT LOOP
      IF prev_end_date IS NOT NULL AND SELF.employee_jobHistories(i).start_date > prev_end_date + 1 THEN
        gap_found := 'TRUE';
        EXIT;
      END IF;
      prev_end_date := SELF.employee_jobHistories(i).end_date;
    END LOOP;
    RETURN gap_found;
  END has_job_history_gaps;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Calculate the Duration of an Employee’s Current Job
CREATE OR REPLACE TYPE BODY employee_t AS
  MEMBER FUNCTION current_job_duration RETURN NUMBER IS
    current_job_start DATE;
  BEGIN
    IF SELF.employee_jobHistories.COUNT > 0 THEN
      current_job_start := SELF.employee_jobHistories(SELF.employee_jobHistories.COUNT).end_date + 1;
    ELSE
      current_job_start := SELF.hire_date;
    END IF;
    RETURN SYSDATE - current_job_start;
  END current_job_duration;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Calculate the Duration of an Employee’s Current Job
--Compare Employees by Job Duration.
CREATE OR REPLACE TYPE BODY employee_t AS
  ORDER MEMBER FUNCTION compare_by_job_duration (e employee_t) RETURN INTEGER IS
  BEGIN
    IF SELF.current_job_duration < e.current_job_duration THEN
      RETURN -1; -- any negative value
    ELSIF SELF.current_job_duration > e.current_job_duration THEN
      RETURN 1; -- any positive value
    ELSE
      RETURN 0;
    END IF;
  END compare_by_job_duration;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Add a New Employee
CREATE OR REPLACE PROCEDURE add_employee (
    p_employee_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_email IN VARCHAR2,
    p_phone_number IN VARCHAR2,
    p_hire_date IN DATE,
    p_salary IN NUMBER,
    p_commission_pct IN NUMBER,
    p_job_id IN VARCHAR2,
    p_department_id IN NUMBER,
    p_manager_id IN NUMBER
) IS
    v_job REF job_t;
    v_department REF department_t;
    v_manager REF employee_t;
BEGIN
    SELECT REF(j) INTO v_job FROM dw_jobs j WHERE j.job_id = p_job_id;
    SELECT REF(d) INTO v_department FROM dw_departments d WHERE d.department_id = p_department_id;
    SELECT REF(e) INTO v_manager FROM dw_employees e WHERE e.employee_id = p_manager_id;

    INSERT INTO dw_employees VALUES (
        p_employee_id, p_first_name, p_last_name, p_email, p_phone_number, p_hire_date,
        p_salary, p_commission_pct, v_job, v_department, v_manager, employee_jobHistories_tab_t()
    );

    COMMIT;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Update Employee Salary
CREATE OR REPLACE PROCEDURE update_employee_salary (
    p_employee_id IN NUMBER,
    p_new_salary IN NUMBER
) IS
BEGIN
    UPDATE dw_employees SET salary = p_new_salary WHERE employee_id = p_employee_id;
    COMMIT;
END;
/
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

-----------------------------------------------------------------------------------------------------------------------
-- Method to Retrieve Employee Details
CREATE OR REPLACE FUNCTION get_employee_details (
    p_employee_id IN NUMBER
) RETURN employee_t IS
    v_employee dw_employees%ROWTYPE;
BEGIN
    SELECT * INTO v_employee FROM dw_employees WHERE employee_id = p_employee_id;
    RETURN v_employee;
END;
/

-----------------------------------------------------------------------------------------------------------------------
-- Method to Check Job History Gaps
CREATE OR REPLACE FUNCTION check_job_history_gaps RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT e.employee_id, COUNT(*) AS gap_count
    FROM dw_employees e
    JOIN TABLE(e.employee_jobHistories) jh
    WHERE jh.start_date > NVL(
        (SELECT MAX(end_date) FROM TABLE(e.employee_jobHistories) WHERE end_date < jh.start_date),
        e.hire_date
    )
    GROUP BY e.employee_id
    HAVING COUNT(*) > 0;
    RETURN v_cursor;
END;
/
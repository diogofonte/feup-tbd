-- User-defined types
CREATE TYPE AddressType AS OBJECT(
    street VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TYPE DateRange AS OBJECT(
    start_date DATE,
    end_date DATE
);

-- Define tables
CREATE TABLE Region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100)
);

CREATE TABLE Country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100),
    region_id INT REFERENCES Region(region_id)
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(255),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    state_province VARCHAR(100),
    country_id INT REFERENCES Country(country_id)
);

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INT REFERENCES Location(location_id)
);

CREATE TABLE Job (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT REFERENCES Job(job_id),
    salary DECIMAL(10, 2),
    commission_pct DECIMAL(4, 2),
    manager_id INT REFERENCES Employee(employee_id),
    department_id INT REFERENCES Department(department_id),
    address AddressType,
    CONSTRAINT chk_hire_date CHECK (hire_date <= CURRENT_DATE)
);

CREATE TABLE JobHistory (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id INT,
    department_id INT,
    CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date),
    CONSTRAINT fk_emp_id FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES Job(job_id),
    CONSTRAINT fk_dept_id FOREIGN KEY (department_id) REFERENCES Department(department_id),
    CONSTRAINT chk_dates CHECK (start_date <= end_date)
);

-- Inheritance: Manager inherits from Employee
CREATE TABLE Manager OF Employee (
    manager_id INT PRIMARY KEY,
    bonus DECIMAL(10, 2)
);

-- Nested tables: Employees can have multiple addresses
CREATE TABLE EmployeeAddresses OF NestedTable (
    employee_id INT,
    address_id INT,
    address AddressType,
    PRIMARY KEY (employee_id, address_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Methods: Calculate age of an employee
CREATE METHOD EmployeeAge AS
    FUNCTION AGE(employee_id INT) RETURNS INT
    BEGIN
        DECLARE birth_date DATE;
        SELECT hire_date INTO birth_date FROM Employee WHERE employee_id = EmployeeAge.employee_id;
        RETURN DATEDIFF(CURRENT_DATE, birth_date);
    END FUNCTION;

-- Methods: Calculate total earnings of an employee
CREATE METHOD EmployeeEarnings AS
    FUNCTION EARNINGS(employee_id INT) RETURNS DECIMAL(10, 2)
    BEGIN
        DECLARE total_earnings DECIMAL(10, 2);
        SELECT salary + (salary * commission_pct) INTO total_earnings FROM Employee WHERE employee_id = EmployeeEarnings.employee_id;
        RETURN total_earnings;
    END FUNCTION;

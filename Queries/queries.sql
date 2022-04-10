-- Creating tables for PH-EmployeeDB
Drop Table departments CASCADE;
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
Drop Table if exists Employees CASCADE;
CREATE TABLE Employees (
     emp_no int  NOT NULL,
     bith_date DATE NOT NULL,
     first_name VARCHAR  NOT NULL ,
     last_name VARCHAR NOT  NULL,
     gender varchar  NOT NULL,
     hire_date date NOT NULL,
     PRIMARY KEY(emp_no)
);

Drop Table if exists dept_manager CASCADE;
CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT  NULL,
    emp_no int  NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
Drop Table if exists salaries CASCADE;
CREATE TABLE salaries (
  emp_no int NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

Drop Table if exists Titles CASCADE;
CREATE TABLE Titles (
  emp_no int NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE  NOT NULL,
  to_date DATE  NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
Drop Table if exists dept_emp CASCADE;
CREATE TABLE dept_emp (
    emp_no int  NOT NULL,
	dept_no VARCHAR(4)  NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL, 
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;
SELECT * FROM Employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;


--Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (employees.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (employees.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (employees.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--saved as a new table.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (employees.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

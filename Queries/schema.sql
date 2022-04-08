-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE Employees (
     emp_no int NOT NULL,
     bith_date DATE NOT NULL,
     first_name VARCHAR NOT NULL ,
     last_name VARCHAR NOT NULL,
     gender varchar NOT NULL,
     hire_date date NOT NULL,
     PRIMARY KEY(emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE Titles (
  emp_no INT NOT NULL,
  title VARCHAR NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    bith_date DATE NOT NULL,
    first_name VARCHAR NOT NULL ,
    last_name VARCHAR NOT NULL,
    gender varchar NOT NULL,
    hire_date date NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;
SELECT * FROM Employees;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;
SELECT * FROM dept_manager;

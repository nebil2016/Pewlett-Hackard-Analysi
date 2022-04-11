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


-- Create new table for retiring employees
Drop Table  retirement_info;
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (employees.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
    retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Aliace table names
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Aliace table names
SELECT r.emp_no,r.first_name,r.last_name,de.to_date
INTO current_emp
FROM retirement_info as r
LEFT JOIN dept_emp AS de
ON r.emp_no=de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


--Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO Employee_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT e.emp_no, e.first_name,
       e.last_name,e.gender,s.salary,
       de.to_date
	   
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON(e.emp_no=s.emp_no)
INNER JOIN dept_emp as de
ON(e.emp_no=de.emp_no)
WHERE (e.bith_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
-- Department Retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);



-- Sales Department Retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO Sales_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name='Sales';


-- Sales and Development Department Retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO Sales_dev_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');

SELECT  * FROM Sales_dev_info;

CREATE TABLE distinct_demo (
	id serial NOT NULL PRIMARY KEY,
	bcolor VARCHAR,
	fcolor VARCHAR
);

INSERT INTO distinct_demo (bcolor, fcolor)
VALUES
	('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue');
	
SELECT
	id,
	bcolor,
	fcolor
FROM
	distinct_demo ;

-- The following statement selects 
-- unique values in the  bcolor 
-- column from the t1 table and
-- sorts the result set in alphabetical order
-- by using the ORDER BY clause.

SELECT
	DISTINCT bcolor
FROM
	distinct_demo
ORDER BY
	bcolor;
--  DISTINCT clause on multiple columns:
SELECT
	DISTINCT bcolor,
	fcolor
FROM
	distinct_demo
ORDER BY
	bcolor,
	fcolor;
	
-- PostgreSQL DISTINCT ON example	
-- for each group of duplicates, it keeps the first row 
-- in the returned result set.
SELECT
	DISTINCT ON (bcolor) bcolor,
	fcolor
FROM
	distinct_demo 
ORDER BY
	bcolor,
	fcolor;

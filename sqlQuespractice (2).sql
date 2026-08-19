use sakila;
select * from employees;

-- Q1. Find employees with salary between 65,000 and 85,000
SELECT emp_id, first_name ,last_name, department,salary FROM employees
WHERE salary BETWEEN 65000 AND 85000;

-- Q2. List employees in the IT or Finance department
SELECT emp_id, first_name ,last_name ,department ,job_title FROM employees
WHERE department IN ('IT','Finance');

-- Q3. Find employees whose last name ends with 'son'
SELECT emp_id , first_name , last_name , department FROM employees
WHERE last_name LIKE '%son'; 

-- Q4. Find active employees (is_active = 'Y') in the IT department
SELECT emp_id ,first_name, last_name ,job_title, department ,salary FROM employees
WHERE is_active = 'Y' AND department = 'IT';

-- Q5. Display first_name in UPPERCASE and last_name in 
-- lowercase for Finance employees
SELECT emp_id , UPPER(first_name) AS first_name_upper, LOWER(last_name) AS last_name_lower, salary FROM employees
WHERE department = 'Finance';

-- Q6. Find employees whose first name has more than 4 characters
SELECT emp_id ,first_name ,LENGTH(first_name), department FROM employees
WHERE LENGTH(first_name) > 4;

-- Q7. Show full name and its character length for Marketing employees
SELECT emp_id ,CONCAT(first_name, ' ', last_name )As full_name , 
LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length , department FROM employees
WHERE department = 'Marketing';

-- Q8. Display hire year and years-ago for each Finance employee
SELECT emp_id , first_name, last_name , hire_date , year(hire_date),
year(now())-year(hire_date) AS years_ago FROM employees 
WHERE department = 'Finance';

-- Q9. Show each IT employees salary rounded to nearest 10,000 and
-- its remainder
SELECT emp_id, first_name ,last_name ,salary, ROUND(salary, -4)As rounded_salary,
MOD(salary , 10000)AS remainder FROM employees 
WHERE  department = 'IT';

-- Q10. Find employees using an Outlook email address 
SELECT emp_id, first_name, last_name, email FROM employees
WHERE email LIKE '%@Outlook.com';

-- Q11. Find employees hired more than 2,000 days ago (from April 28, 2026)



-- Q12. Extract the email username (part before @ ) for all HR employees
-- learn => LOCATE() is used to find the position of a character or word
-- inside a string.

SELECT emp_id,first_name,last_name,email,
SUBSTR(email, 1, LOCATE('@', email) - 1) AS username
FROM employees
WHERE department = 'HR';

-- Q13. Find non-IT/Finance employees with salary outside the 60,000–80,000 range
SELECT CONCAT(first_name, ' ', last_name )As full_name , department, salary FROM employees
WHERE department NOT IN ('IT', 'Finance') AND salary NOT BETWEEN 60000 AND 80000;


-- Q14. Extract and uppercase the email username; show only those
-- with username length > 6 characters
SELECT emp_id,first_name,last_name,email,
UPPER(SUBSTR(email, 1, LOCATE('@', email) - 1)) AS username_upper,
LENGTH(SUBSTR(email, 1, LOCATE('@', email) - 1)) AS username_length
FROM employees
WHERE LENGTH(SUBSTR(email, 1, LOCATE('@', email) - 1)) > 6;






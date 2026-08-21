create database alltypejoins;
use  alltypejoins;

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50),
location VARCHAR(50)
);
INSERT INTO departments VALUES
(10,'HR','Jaipur'),
(20,'IT','Bangalore'),
(30,'Finance','Mumbai'),
(40,'Marketing','Delhi'),
(50,'Legal','Pune');

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
dept_id INT,
salary INT,
city VARCHAR(50)
);
INSERT INTO employees VALUES
(101,'Amit',10,45000,'Jaipur'),
(102,'Bhavna',20,72000,'Bangalore'),
(103,'Chirag',20,68000,'Bangalore'),
(104,'Divya',30,55000,'Mumbai'),
(105,'Esha',NULL,39000,'Delhi'),
(106,'Farhan',40,61000,'Delhi'),
(107,'Gaurav',60,50000,'Kolkata'),
(108,'Hina',30,83000,'Mumbai');

CREATE TABLE projects (
proj_id INT PRIMARY KEY,
proj_name VARCHAR(50),
dept_id INT,
budget INT
);

INSERT INTO projects VALUES
(1,'Payroll Revamp',10,120000),
(2,'Cloud Migration',20,500000),
(3,'Mobile App',20,300000),
(4,'Audit Automation',30,250000),
(5,'Brand Refresh',40,180000),
(6,'Data Lake',70,400000);

-- Q1. List each employee with their department name and location.
select e.emp_id , e.emp_name , d.dept_name , d.location 
from employees e
inner join departments d 
on e.dept_id = d.dept_id;
 z
-- Q2. Show every project along with the name of the department that owns it.
select p.proj_id , p.proj_name , d.dept_name , p.budget
from projects p 
inner join departments d 
on p.dept_id = d.dept_id;

-- Q3. Show employee names together with the projects run by their own department.
select e.emp_name, d.dept_name, p.proj_name
from employees e
inner join departments d
on e.dept_id = d.dept_id
inner join projects p
on d.dept_id = p.dept_id;

-- Q4. List ALL employees with  their department name; show NULL when the employee has no matching
-- department.
select e.emp_id , e.emp_name  , d.dept_id , d.dept_name 
from employees e 
left join departments d 
on e.dept_id = d.dept_id; 

-- Q5. List ALL departments with their projects; departments with no project must still appear.
select d.dept_id , d.dept_name , p.proj_name , p.budget 
from departments d 
left join projects p 
on d.dept_id = p.dept_id;

-- Q6. Find only those employees who do NOT belong to any valid department.
select e.emp_id , e.emp_name , e.dept_id 
from employees e 
left join departments d 
on e.dept_id = d.dept_id
where d.dept_id is null;

-- Q7. List ALL departments and any employees in them, using a RIGHT JOIN with employees on the left.
select e.emp_name , d.dept_id , d.dept_name 
from employees e 
right join departments d 
on e.dept_id = d.dept_id;

-- Q8. List ALL projects and the department that owns them, keeping projects that point to a missing department.
select d.dept_name , p.proj_id , p.proj_name , p.dept_id 
from departments d 
right join projects p 
on d.dept_id = p.dept_id;

-- Q9. Find departments that currently have NO employee assigned.
select d.dept_id , d.dept_name , d.location 
from departments d 
left join employees e 
on e.dept_id = d.dept_id
where e.emp_id is null;

-- Q10. Produce every possible pairing of the Finance/Legal departments with employees earning above 70000.
select e.emp_name,e.salary,d.dept_name
from employees e
cross join departments d
where e.salary > 70000 and d.dept_name in ('Finance', 'Legal');
  
-- Q11. Pair every project having a budget of at least 400000 with every department located in Mumbai or Pune.
select p.proj_name , p.budget , d.dept_name , d.location
from  projects p 
cross join departments d 
where budget >= 400000 and d.location in ('mumbai','pune');

-- Q12. How many total row combinations result from CROSS JOIN of employees and departments? Show the count.
select count(*) as total_combination 
from employees 
cross join departments ;

-- Q13. Show employees whose salary is greater than 60000.
select * from employees 
where salary > 60000;

-- Q14. Show all employees based in Delhi or Mumbai.
select * from employees 
where city In ('Delhi','Mumbai');

-- Q15. Show employees whose dept_id is NULL (unassigned employees).
select * from employees 
where dept_id is null ; 

-- Q16. Show departments located in Bangalore or Delhi.
select * from departments 
where location In ('Bangalore','Delhi');

-- Q17. Show departments whose dept_id is 30 or higher.
select * from departments 
where dept_id >= 30;

-- Q18. Show departments whose name starts with the letter "F" or "L".
select * from departments 
where dept_name LIKE 'F%' or dept_name LIKE 'L%';

-- Q19. Show projects with a budget between 200000 and 400000 (inclusive).
select * from projects 
where budget between 200000 and 400000;

-- Q20. Show all projects that belong to dept_id 20.
select * from projects 
where dept_id = 20;

-- Q21. Show projects whose name contains the word "a" and budget is under 300000. 
select * from projects 
where proj_name like '%a%' and budget < 300000;

-- Q22. Show employee name, department name, location and project name for all matching rows across all three tables. 
 select e.emp_name , d.dept_name , d.location , p.proj_name , p.budget
 from employees e 
 join departments d 
 on e.dept_id = d.dept_id
 join projects p 
 on d.dept_id = p.dept_id;
 
 select dept_name,count(emp_id) from employees as e
 join departments as d 
 on e.dept_id = d.dept_id
 
 group by dept_name;
 having count(emp_id) > 1


 
 
 
-- Q23. Show ALL employees, plus department and project details where available (keep employees even with no dept/project). 
select e.emp_id, e.emp_name, d.dept_name, p.proj_name
from employees e
left join departments d
on e.dept_id = d.dept_id
left join projects p
on d.dept_id = p.dept_id;

-- Q24. Show employees earning more than 60000 along with department and any project over 250000 budget. 
select e.emp_name , e.salary , d.dept_name , p.proj_name , p.budget
from employees e 
left join departments d 
on e.dept_id = d.dept_id
left join projects p 
on d.dept_id = p.dept_id
where salary > 60000 and budget > 250000;

-- Q25. List ALL departments with their employees and projects, including departments having neither.
select d.dept_id , d.dept_name , e.emp_name , p.proj_name 
from departments d 
left join employees e 
on d.dept_id = e.dept_id 
left join projects p 
on e.dept_id = p.dept_id;

-- Q26. Show employees who work in a department located in Bangalore or Mumbai, along with the projects of that department.
select e.emp_name , d.location , p.proj_name 
from employees e 
left join departments d 
on e.dept_id = d.dept_id 
left join projects p 
on d.dept_id = p.dept_id
where location IN ('bangalore','mumbai');

-- Q27. Pair employees who work in the same city (avoid duplicate pairs and self-pairing).
SELECT e1.emp_name AS employee_1 , e2.emp_name AS employee_2 , e1.city
FROM employees e1
inner join employees e2
on e1.city = e2.city and e1.emp_id < e2.emp_id; 

-- Q28. Show every project along with employees of that department; keep projects with no employees. 
select p.proj_name, p.dept_id, e.emp_name
from projects p
left join employees e
on p.dept_id = e.dept_id;
-- 
-- select  dept_name, sum(buget) from project as p 
-- join 


--  you need to find the dept name and total number of employee that deptment  

-- group by ke sath where or having dono chl skte hai 

-- select name,population ,independence , if independceyear >1947 ,'after india' ,'before india' from country ;
-- select col1,col2
-- case 
-- when  condition  then 
--    when condition then
-- end case 
-- from table    

select name, population ,indepyear,
case 
	when indepyear > 1947 then 'after 1947'
    when indepyear>=1919 then 'only after 1919'
    else 'else condition'
end case 
from country;    
-- country continet population create catgore\ry agar meri  contry population 2lakh 
-- 5lakh avg popultaion agr 5  se jada large population or baki ke case mai apn krge small population 
SELECT
    country,
    continent,
    population,
    CASE
        WHEN population BETWEEN 200000 AND 500000 THEN 'Average Population'
        WHEN population > 500000 THEN 'Large Population'
        ELSE 'Small Population'
    END 
FROM country;

-- find  continent name and number of country with the catgory of the 
-- continentt colum hame sabse phle contine ka name nikln ahia usme konsi contry  or usme 
-- number of contry 10 se jada hui small continennt 15 se jada hui avg continnt 25 se jada large scal continent 
SELECT
    continent,
    COUNT(country) AS number_of_countries,
    CASE
        WHEN COUNT(country) > 25 THEN 'Large Scale Continent'
        WHEN COUNT(country) > 15 THEN 'Average Continent'
        WHEN COUNT(country) > 10 THEN 'Small Continent'
    END 
FROM country GROUP BY continent;

create  database corr_db;
use corr_db;
create table employees_c( id int , name varchar(20),salary int);
insert into employees_c values (1,'a',100),(2,'b',250),(3,'c',400),(4,'d',300);
select name,salary from employees_c
where salary = (select min(salary) from employees_c);
insert into employees_c values (5,'m',250);
select *from employees_c where salary = (select salary from employees_c where name='b');
select * from employees_c;
DELETE FROM employees_c
WHERE id = 2;
SET SQL_SAFE_UPDATES = 0;
SELECT @@SQL_SAFE_UPDATES;
select name,salary from employees_c where salary > (select avg(salary) from employees_c );
use world;
select * from city;
-- get the name of ccity where the district of city is same for the abu dabhi 
-- get all the colum from thw city table where population is maxisium 
-- get the distrect and the name of city where country code is same for herat
-- get the district city and population for all the country where amsadham sort the data by the populattion 
-- --------------------------------------------------------------------------------------- 
-- ---------------------------------------------------------------------------------------
select name from city where district =(select district from city where name ='Abu Dhabi');
select * from city  where population =(select max(papulation) from city );
SELECT district, name FROM city WHERE countrycode = (SELECT countrycode FROM city WHERE name = 'Herat');
SELECT district, city, population FROM city WHERE countrycode = (SELECT countrycode FROM city WHERE name = 'Amsadedam')
ORDER BY population;
-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------

-- Set7 - Subquery (1) (1).pdf
-- 🟢 SECTION 1 — EASY Q1–Q30

-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------
-- Q1 — Salary greater than company average
SELECT emp_name, department, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;
-- 2 — Highest-paid employee
SELECT emp_id, emp_name, department, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

-- Q3 — Lowest-paid employee
SELECT emp_id, emp_name, department, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- Q4 — Rachel King ke same hire year wale employees
SELECT emp_name, department, hire_year
FROM employees
WHERE hire_year = (
    SELECT hire_year
    FROM employees
    WHERE emp_name = 'Rachel King'
)
AND emp_name <> 'Rachel King';

-- Q5 — Average product price se expensive products
SELECT product_name, category, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;

-- Q6 — Most expensive product
SELECT product_id, product_name, category, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- Q7 — Cheapest product
SELECT product_id, product_name, category, price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);
-- Q8 — Average order amount se greater orders
SELECT order_id, customer_id, amount
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
)
ORDER BY amount DESC;

-- Q9 — Most expensive order
SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE amount = (
    SELECT MAX(amount)
    FROM orders
);

-- R-- Q10 — Customers who placed at least one order
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
)
ORDER BY customer_id;

-- Q11 — Customers who never placed an order
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
)
ORDER BY customer_id;

-- Q12 — Products appearing in orders
SELECT product_id, product_name, category, price
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM orders
);
-- Q13 — Products never ordered
SELECT product_id, product_name, category, price
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM orders
);

-- Q14 — Finance department employees using IN subquery
SELECT emp_name, salary
FROM employees
WHERE department IN (
    SELECT dept_name
    FROM departments
    WHERE dept_name = 'Finance'
)
ORDER BY salary DESC;

-- Q15 — Salary less than minimum Finance salary
SELECT emp_name, department, salary
FROM employees
WHERE salary < (
    SELECT MIN(salary)
    FROM employees
    WHERE department = 'Finance'
)
ORDER BY salary DESC;

-- Q16 — Highest-budget department
SELECT dept_name, budget, location
FROM departments
WHERE budget = (
    SELECT MAX(budget)
    FROM departments
);

-- Q17 — Exactly 1 order wale customers
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) = 1
);

-- Q18 — 2 or more orders wale customers
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) >= 2
)
ORDER BY customer_id;

-- Q19 — Accessories ke maximum price se expensive products
SELECT product_name, category, price
FROM products
WHERE price > (
    SELECT MAX(price)
    FROM products
    WHERE category = 'Accessories'
)
ORDER BY price DESC;

-- 20 — 2021 mein join hue customers ke orders
SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE join_year = 2021
)
ORDER BY order_date;

-- Q21 — Managers using EXISTS
SELECT e.emp_id, e.emp_name, e.department
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees x
    WHERE x.manager_id = e.emp_id
)
ORDER BY e.emp_name;

-- Q22 — Non-managers using NOT EXISTS
SELECT e.emp_id, e.emp_name, e.department
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees x
    WHERE x.manager_id = e.emp_id
)
ORDER BY e.emp_id;

-- 23 — Customers with at least one order using EXISTS
SELECT c.customer_id, c.customer_name, c.city
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- Q24 — Customers with no orders
SELECT c.customer_id, c.customer_name, c.city
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- Q25 — Products appearing in orders using EXISTS
SELECT p.product_id, p.product_name, p.category
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.product_id = p.product_id
)
ORDER BY p.product_id;

-- Q26 — Eva Green ke same department ke employees
SELECT emp_name, department, salary
FROM employees
WHERE department = (
    SELECT department
    FROM employees
    WHERE emp_id = 105
)
AND emp_id <> 105
ORDER BY salary DESC;

-- Q27 — Most recent order
SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE order_date = (
    SELECT MAX(order_date)
    FROM orders
);

-- Q28 — Earliest order
SELECT order_id, customer_id, amount, order_date
FROM orders
WHERE order_date = (
    SELECT MIN(order_date)
    FROM orders
);

-- Q29 — Salary greater than every HR employee
SELECT emp_name, department, salary
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department = 'HR'
)
ORDER BY salary DESC;

-- Q30 — Delivered orders above Delivered average
SELECT order_id, customer_id, amount, status
FROM orders
WHERE status = 'Delivered'
AND amount > (
    SELECT AVG(amount)
    FROM orders
    WHERE status = 'Delivered'
)
ORDER BY amount DESC;

Logic: Average sirf Delivered orders ka calculate hoga.

Result: 1006, 1018, 1016, 1010, 1004, 1012.

🟡 SECTION 2 — INTERMEDIATE Q31–Q45
Q31 — Department average se greater salary
SELECT e.emp_name,
       e.department,
       e.salary,
       ROUND((
           SELECT AVG(x.salary)
           FROM employees x
           WHERE x.department = e.department
       ), 2) AS dept_avg
FROM employees e
WHERE e.salary > (
    SELECT AVG(x.salary)
    FROM employees x
    WHERE x.department = e.department
)
ORDER BY e.department, e.salary DESC;

Logic: Har employee ke department ka average separately calculate ho raha hai.

Result: Finance — Rachel, Eva, Nate; HR — Carol, Tina; IT — Alice, Olivia, Grace; Marketing — Mia, Henry.

Q32 — Same department mein kitne higher earners hain
SELECT e.emp_name,
       e.department,
       e.salary,
       (
           SELECT COUNT(*)
           FROM employees x
           WHERE x.department = e.department
             AND x.salary > e.salary
       ) AS higher_earners
FROM employees e
ORDER BY e.department, e.salary DESC;

Logic: Har employee ke liye same department mein usse higher salary wale employees count hote hain.

Example:

Rachel → 0
Eva → 1
Nate → 2

Q33 — Average customer total spend se greater customers
SELECT c.customer_id,
       c.customer_name,
       (
           SELECT SUM(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS total_spend
FROM customers c
WHERE (
    SELECT SUM(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(total_spend)
    FROM (
        SELECT customer_id, SUM(amount) AS total_spend
        FROM orders
        GROUP BY customer_id
    ) x
)
ORDER BY total_spend DESC;

Result:

Aarav Mehta — 7400
Neha Singh — 5900
Vikram Rao — 5700
Arjun Kumar — 4900

Q34 — Department average salary > 65000
SELECT emp_name, department, salary
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > 65000
)
ORDER BY department, salary DESC;

Logic: Pehle qualifying departments find hote hain, phir un departments ke employees.

Result: Finance + IT employees.

Q35 — Customer's own average ke against order label
SELECT o.order_id,
       o.customer_id,
       o.amount,
       CASE
           WHEN o.amount >= (
               SELECT AVG(x.amount)
               FROM orders x
               WHERE x.customer_id = o.customer_id
           )
           THEN 'Above Avg'
           ELSE 'Below Avg'
       END AS vs_cust_avg
FROM orders o
ORDER BY o.customer_id, o.order_id;

Logic: Har order ko us customer ke personal average se compare kiya ja raha hai.

Example:

Customer 201:

1500 → Below Avg
3200 → Above Avg
2700 → Above Avg

Q36 — Category average price se expensive products
SELECT p.product_name,
       p.category,
       p.price,
       ROUND((
           SELECT AVG(x.price)
           FROM products x
           WHERE x.category = p.category
       ), 2) AS cat_avg
FROM products p
WHERE p.price > (
    SELECT AVG(x.price)
    FROM products x
    WHERE x.category = p.category
)
ORDER BY p.category, p.price DESC;

Logic: Product ko uski own category ke average price se compare karte hain.

Result: Keyboard, USB Hub, Laptop, Smartphone, Monitor, Smart Watch, Standing Desk, Pen Set.

Q37 — Marketing ke at least one employee se higher salary — ANY
SELECT emp_name, department, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Marketing'
)
ORDER BY salary DESC;

Important: > ANY ka meaning hai at least one value se greater.

Marketing minimum salary = 56000.

Isliye salary > 56000 qualify karegi.

Q38 — Finance ke EVERY employee se lower salary — ALL
SELECT emp_name, department, salary
FROM employees
WHERE salary < ALL (
    SELECT salary
    FROM employees
    WHERE department = 'Finance'
)
ORDER BY salary DESC;

Important:

< ALL = Finance ki har salary se less.

Finance minimum = 70000.

Therefore salary < 70000.

Q39 — At least one order AND all orders Delivered
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status <> 'Delivered'
)
ORDER BY c.customer_id;

Logic:

EXISTS → customer ke paas order hona chahiye.
NOT EXISTS → koi Pending/Cancelled order nahi hona chahiye.

Result: 205, 206, 207, 209, 210.

Q40 — Mumbai customers ke ordered products
SELECT product_id, product_name, category
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM orders
    WHERE customer_id IN (
        SELECT customer_id
        FROM customers
        WHERE city = 'Mumbai'
    )
)
ORDER BY product_id;

Logic:

Mumbai
  ↓
Customer IDs
  ↓
Orders
  ↓
Product IDs
  ↓
Products

Result: 301 Laptop, 302 Smartphone, 304 Monitor.

Q41 — Second-highest salary
SELECT emp_name, department, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);

Logic:

Highest = 82000
Highest se less salaries mein MAX = 80000
Employee = Eva Green

Result: Eva Green — Finance — 80000.

Q42 — Departments where every employee earns > 50000
SELECT DISTINCT e.department
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees x
    WHERE x.department = e.department
      AND x.salary <= 50000
)
ORDER BY e.department;

Logic: Aisa employee exist nahi karna chahiye jiska salary <= 50000 ho.

Result: Finance, IT, Marketing. HR exclude hoga because Leo = 50000.

Q43 — Customers who ordered at least 2 different products
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE (
    SELECT COUNT(DISTINCT o.product_id)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) >= 2
ORDER BY c.customer_id;

Logic: Customer-wise distinct product_id count.

Result: Customers 201–209.

Q44 — Salary > same year's average salary
SELECT e.emp_name,
       e.department,
       e.salary,
       e.hire_year,
       ROUND((
           SELECT AVG(x.salary)
           FROM employees x
           WHERE x.hire_year = e.hire_year
       ), 2) AS year_avg
FROM employees e
WHERE e.salary > (
    SELECT AVG(x.salary)
    FROM employees x
    WHERE x.hire_year = e.hire_year
)
ORDER BY e.hire_year, e.salary DESC;

Logic: Har employee ki salary ko uske hire year ke average se compare karte hain.

Result: Rachel, Olivia, Frank, Alice, Nate, Jack, Karen, Grace, Sam.

Q45 — Category average stock se less stock
SELECT p.product_name,
       p.category,
       p.stock_qty,
       ROUND((
           SELECT AVG(x.stock_qty)
           FROM products x
           WHERE x.category = p.category
       ), 2) AS cat_avg_stock
FROM products p
WHERE p.stock_qty < (
    SELECT AVG(x.stock_qty)
    FROM products x
    WHERE x.category = p.category
)
ORDER BY p.category, p.stock_qty ASC;

Logic: Product ka stock apni category ke average stock se compare hota hai.

Result: USB Hub, Keyboard, Scanner, Printer, Laptop, Monitor, Smart Watch, External SSD, Standing Desk, Desk Chair, Notebook.

🔴 SECTION 3 — HARD Q46–Q60
Q46 — Top 3 distinct salaries
SELECT emp_name, department, salary
FROM employees
WHERE salary IN (
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 3
)
ORDER BY salary DESC;

Logic:

DISTINCT salaries
      ↓
DESC order
      ↓
LIMIT 3
      ↓
82000, 80000, 78000

Result: Rachel, Eva, Nate.

Q47 — Every order amount > 1000
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.amount <= 1000
)
ORDER BY c.customer_id;

Logic: Customer ka at least one order hona chahiye aur <= 1000 ka koi order nahi hona chahiye.

Result: 201, 205, 206, 207, 210.

Q48 — Department average ke closest employee
SELECT e.emp_name,
       e.department,
       e.salary,
       ROUND((
           SELECT AVG(x.salary)
           FROM employees x
           WHERE x.department = e.department
       ), 2) AS dept_avg,
       ABS(
           e.salary - (
               SELECT AVG(x.salary)
               FROM employees x
               WHERE x.department = e.department
           )
       ) AS diff
FROM employees e
WHERE ABS(
    e.salary - (
        SELECT AVG(x.salary)
        FROM employees x
        WHERE x.department = e.department
    )
) = (
    SELECT MIN(
        ABS(
            y.salary - (
                SELECT AVG(z.salary)
                FROM employees z
                WHERE z.department = y.department
            )
        )
    )
    FROM employees y
    WHERE y.department = e.department
)
ORDER BY e.department;

Logic:
Har employee ka:

Salary - Department Average
        ↓
ABS()
        ↓
Difference
        ↓
Department ka MIN difference

Result: Nate Lewis, David Brown, Grace Lee, Quinn Young.

Q49 — Customers who ordered ALL products ordered by customer 201
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE c.customer_id <> 201
AND NOT EXISTS (
    SELECT 1
    FROM orders o201
    WHERE o201.customer_id = 201
      AND NOT EXISTS (
          SELECT 1
          FROM orders ox
          WHERE ox.customer_id = c.customer_id
            AND ox.product_id = o201.product_id
      )
)
ORDER BY c.customer_id;

Logic: Customer 201 ne jo products order kiye, unmein se ek bhi product candidate customer ke missing nahi hona chahiye.

Result: No rows.

Q50 — Departments whose salary bill > minimum department total
SELECT department,
       SUM(salary) AS dept_total
FROM employees
GROUP BY department
HAVING SUM(salary) > (
    SELECT MIN(dept_total)
    FROM (
        SELECT department,
               SUM(salary) AS dept_total
        FROM employees
        GROUP BY department
    ) x
)
ORDER BY dept_total DESC;

Logic:

Har department ka total salary.
Un totals ka minimum.
Jo department minimum se greater hai, woh qualify karega.

Important: PDF ke expected output mein IT 405000, Finance 385000, aur HR 270000 diya gaya hai.
Lekin supplied table data ke hisaab se Marketing ka total 277000 hai, jo HR ke 270000 se greater hai. Isliye logically query ka result Marketing ko bhi include karega. Yahan PDF ke expected output aur underlying data mein inconsistency hai.

Q51 — Employees earning more than their manager
SELECT e.emp_name,
       e.salary AS emp_salary,
       (
           SELECT m.emp_name
           FROM employees m
           WHERE m.emp_id = e.manager_id
       ) AS manager_name,
       (
           SELECT m.salary
           FROM employees m
           WHERE m.emp_id = e.manager_id
       ) AS manager_salary
FROM employees e
WHERE e.manager_id IS NOT NULL
AND e.salary > (
    SELECT m.salary
    FROM employees m
    WHERE m.emp_id = e.manager_id
)
ORDER BY emp_salary DESC;

Logic: Employee ki salary ko uske manager ki salary se compare karte hain.

Result:

Employee	Salary	Manager	Manager Salary
Rachel King	82000	Eva Green	80000
Mia Clark	62000	Henry Wilson	60000

Q52 — Products whose order count > average order count
SELECT p.product_id,
       p.product_name,
       (
           SELECT COUNT(*)
           FROM orders o
           WHERE o.product_id = p.product_id
       ) AS order_count
FROM products p
WHERE p.product_id IN (
    SELECT product_id
    FROM orders
)
AND (
    SELECT COUNT(*)
    FROM orders o
    WHERE o.product_id = p.product_id
) > (
    SELECT AVG(order_count)
    FROM (
        SELECT product_id,
               COUNT(*) AS order_count
        FROM orders
        GROUP BY product_id
    ) x
);

Logic: Ordered products = 4, each has exactly 5 orders.

Average = 5.

Koi product > 5 nahi hai.

Result: No rows.

Q53 — Customer whose best order = global best order
SELECT c.customer_id,
       c.customer_name,
       (
           SELECT MAX(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS best_order
FROM customers c
WHERE (
    SELECT MAX(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) = (
    SELECT MAX(amount)
    FROM orders
);

Logic:

Global maximum = 4500.

Jis customer ka personal maximum bhi 4500 hai, woh qualify karega.

Result: Vikram Rao — 4500.

Q54 — Employees in departments with above-average budget
SELECT emp_name, department, salary
FROM employees
WHERE department IN (
    SELECT dept_name
    FROM departments
    WHERE budget > (
        SELECT AVG(budget)
        FROM departments
    )
)
ORDER BY department, salary DESC;

Department budgets:

IT = 500000
HR = 200000
Finance = 600000
Marketing = 300000

Average = 400000.

Therefore IT + Finance qualify.

Result: Finance and IT employees.

Q55 — Orders above customer's personal average
SELECT c.customer_id,
       c.customer_name,
       (
           SELECT COUNT(*)
           FROM orders o
           WHERE o.customer_id = c.customer_id
             AND o.amount > (
                 SELECT AVG(x.amount)
                 FROM orders x
                 WHERE x.customer_id = c.customer_id
             )
       ) AS orders_above_avg
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY orders_above_avg DESC,
         c.customer_id;

Logic: Har customer ka personal average calculate hota hai, phir usse greater orders count hote hain.

Result:

201 Aarav Mehta       2
202 Priya Sharma      1
203 Rohan Gupta       1
204 Sunita Patel      1
205 Vikram Rao        1
206 Neha Singh        1
207 Arjun Kumar       1
208 Deepa Nair        1
209 Sanjay Joshi      1
210 Meera Iyer        0

Q56 — Products ordered exclusively from one city
SELECT p.product_id,
       p.product_name,
       (
           SELECT MIN(c.city)
           FROM customers c
           WHERE c.customer_id IN (
               SELECT o.customer_id
               FROM orders o
               WHERE o.product_id = p.product_id
           )
       ) AS only_city
FROM products p
WHERE p.product_id IN (
    SELECT product_id
    FROM orders
)
AND (
    SELECT COUNT(DISTINCT c.city)
    FROM customers c
    WHERE c.customer_id IN (
        SELECT o.customer_id
        FROM orders o
        WHERE o.product_id = p.product_id
    )
) = 1;

Logic: Product ke customers ki distinct cities count karo.

Agar count = 1, product sirf ek city se ordered hua.

Result: No rows — har ordered product multiple cities ke customers ne order kiya hai.

Q57 — Department ka sole highest earner
SELECT e.emp_name,
       e.department,
       e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(x.salary)
    FROM employees x
    WHERE x.department = e.department
)
AND (
    SELECT COUNT(*)
    FROM employees x
    WHERE x.department = e.department
      AND x.salary = e.salary
) = 1
ORDER BY e.salary DESC;

Logic: Employee:

Department ka maximum salary earner hona chahiye.
Us salary par department mein sirf 1 employee hona chahiye.

Result: Rachel King, Alice Johnson, Mia Clark, Carol White.

Q58 — Total spend > 2 × average customer spend
SELECT c.customer_id,
       c.customer_name,
       (
           SELECT SUM(o.amount)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS total_spend
FROM customers c
WHERE (
    SELECT SUM(o.amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > 2 * (
    SELECT AVG(total_spend)
    FROM (
        SELECT customer_id,
               SUM(amount) AS total_spend
        FROM orders
        GROUP BY customer_id
    ) x
);

Logic:

Average customer spend ≈ 3895

Double ≈ 7790

Highest customer spend = 7400

Therefore koi customer qualify nahi karta.

Result: No rows.

Q59 — Department with highest number of above-company-average earners
SELECT e.department,
       (
           SELECT COUNT(*)
           FROM employees x
           WHERE x.department = e.department
             AND x.salary > (
                 SELECT AVG(salary)
                 FROM employees
             )
       ) AS above_avg_count
FROM employees e
GROUP BY e.department
ORDER BY above_avg_count DESC
LIMIT 1;

Logic:

Company-wide average salary.
Har department mein us average se greater salary wale employees count.
Highest count wala department select.

Result:

IT | 5

Q60 — Department highest earner but overall salary rank > 3
SELECT e.emp_name,
       e.department,
       e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(x.salary)
    FROM employees x
    WHERE x.department = e.department
)
AND (
    SELECT COUNT(DISTINCT x.salary)
    FROM employees x
    WHERE x.salary > e.salary
) >= 3
ORDER BY e.salary DESC;
Logic

Pehli condition:

e.salary = department ka MAX salary


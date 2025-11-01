# SQL Assignment
/*
Question 1 : Explain the fundamental differences between DDL, DML, and DQL commands in SQL.
Provide one example for each type of command. 

Answer :

1. DDL (Data Definition Language)
Purpose:
DDL commands are used to define, modify, or remove the structure of database objects like tables, schemas, indexes, etc.
Key Feature:
They change the schema of the database and are auto-committed (changes cannot be rolled back).
Common Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME
Example:
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

2. DML (Data Manipulation Language)
Purpose:
DML commands are used to manipulate or modify the data stored in database tables.
Key Feature:
They operate on data, not on schema, and can be rolled back if used inside a transaction.
Common Commands: INSERT, UPDATE, DELETE
Example:
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'John Doe', 55000);

3. DQL (Data Query Language)
Purpose:
DQL is used to query or retrieve data from the database.
Key Feature:
It does not modify data, only fetches it based on given conditions.
Common Command: SELECT
Example:
SELECT Name, Salary
FROM Employees
WHERE Salary > 50000;

4. DCL (Data Control Language)
Purpose:
DCL commands are used to control access and permissions to database objects.
Key Feature:
They manage user privileges and database security.
Common Commands: GRANT, REVOKE
Example:
GRANT SELECT, INSERT ON Employees TO user1;

5. TCL (Transaction Control Language)
Purpose:
TCL commands are used to manage transactions within a database, ensuring data integrity and consistency.
Key Feature:
They control the execution of DML commands — allowing you to commit or roll back changes.
Common Commands: COMMIT, ROLLBACK, SAVEPOINT
Example:
BEGIN TRANSACTION;
UPDATE Employees SET Salary = Salary + 5000 WHERE EmpID = 1;
COMMIT;
Summary Table
Category	Full Form	Purpose	Affects Schema/Data	Example Command
DDL	Data Definition Language	Defines database structure	Schema	CREATE TABLE
DML	Data Manipulation Language	Modifies data	Data	INSERT INTO
DQL	Data Query Language	Retrieves data	Data (read-only)	SELECT
DCL	Data Control Language	Manages access/permissions	Security	GRANT
TCL	Transaction Control Language	Manages transactions	Data integrity	COMMIT
________________________________________

Question 2 : What is the purpose of SQL constraints? 
Name and describe three common types of constraints, providing a simple scenario where each would be useful. 

Answer :

Purpose of SQL Constraints
SQL constraints are rules enforced on data columns in a database table to ensure the accuracy, reliability, and integrity of the data.
They prevent invalid data entry and maintain consistency across related tables.
Three Common Types of Constraints

1. PRIMARY KEY Constraint
•	Purpose: Ensures that each record in a table is unique and not null.
•	Definition: A primary key uniquely identifies each row in a table.
•	Scenario:
Suppose you have a table of employees:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50)
);
Here, EmployeeID is unique for each employee — preventing duplicate or missing employee IDs.

2. FOREIGN KEY Constraint
•	Purpose: Maintains referential integrity between two related tables.
•	Definition: A foreign key in one table refers to a primary key in another table.
•	Scenario:
Suppose you have two tables — Employees and Departments:
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
The DeptID in Employees ensures that each employee must belong to a valid department from the Departments table.

3. CHECK Constraint
•	Purpose: Ensures that values in a column meet a specific condition.
•	Definition: A check constraint limits the values that can be stored in a column.
•	Scenario:
Suppose you want to make sure employee salaries are always above 0:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2) CHECK (Salary > 0)
);
This ensures no employee can have a zero or negative salary.
Summary Table
Constraint	Purpose	Example Use Case
PRIMARY KEY	Uniquely identifies records	Employee ID in an Employees table
FOREIGN KEY	Enforces relationships between tables	Ensures valid Department IDs for Employees
CHECK	Validates data values	Salary must be greater than 0
________________________________________

Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. 
How would you use them together to retrieve the third page of results, assuming each page has 10 records? 

Answer :

Difference between LIMIT and OFFSET in SQL
Both LIMIT and OFFSET are used for pagination — controlling how many rows are returned and from where the result set starts.

1. LIMIT Clause
•	Purpose: Specifies the maximum number of rows to return.
•	Example:
SELECT * FROM Employees
LIMIT 10;
→ Returns the first 10 records.

2. OFFSET Clause
•	Purpose: Specifies the number of rows to skip before starting to return rows.
•	Example:
SELECT * FROM Employees
OFFSET 10;
→ Skips the first 10 records and returns all remaining ones.
Using LIMIT and OFFSET Together
To paginate data — for example, to display results page by page — you use both together.
Scenario: Retrieve the 3rd page of results, with 10 records per page
•	Formula for OFFSET:
•	OFFSET = (page_number - 1) * records_per_page
For page 3:
OFFSET = (3 - 1) * 10 = 20
•	SQL Query:
SELECT * FROM Employees
LIMIT 10
OFFSET 20;
Explanation:
•	OFFSET 20 → skips the first 20 records (page 1 and 2).
•	LIMIT 10 → returns the next 10 records (page 3).
Summary Table
Clause	Function	Example	Result
LIMIT	Restricts how many rows are returned	LIMIT 10	Returns 10 rows
OFFSET	Skips a given number of rows before returning results	OFFSET 20	Skips first 20 rows
LIMIT + OFFSET	Used for pagination	LIMIT 10 OFFSET 20	Page 3 (records 21–30)
________________________________________

Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main benefits? 
Provide a simple SQL example demonstrating its usage. 

Answer :

A Common Table Expression (CTE) is a temporary, named result set that exists only during the execution of a query.
It’s defined using the WITH keyword and can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement — similar to using a temporary table or subquery, but more readable and reusable.
Syntax
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
Main Benefits of CTEs
Benefit	Description
1. Readability	Makes complex SQL queries easier to read and maintain by breaking them into logical parts.
2. Reusability	The same CTE can be referenced multiple times within a query.
3. Recursive Queries	Supports recursion (e.g., for hierarchical or tree-structured data such as employee–manager relationships).
4. Avoids Repetition	Eliminates the need to repeat subqueries multiple times.

Example: Using a Simple CTE
Suppose you want to find all employees who earn more than the average salary.
WITH AvgSalary AS (
    SELECT AVG(Salary) AS avg_sal
    FROM Employees
)
SELECT Name, Salary
FROM Employees, AvgSalary
WHERE Employees.Salary > AvgSalary.avg_sal;
Explanation:
•	The CTE AvgSalary computes the average salary once.
•	The main query then retrieves all employees whose salary is greater than that average.

Example 2: Recursive CTE (Optional Example)
To find the hierarchy under a specific manager:
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE ManagerID IS NULL  -- Top-level manager

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;
This example recursively retrieves all employees reporting to a top-level manager — directly or indirectly.
Summary
Feature	CTE
Introduced by	WITH keyword
Scope	Exists only for the duration of the main query
Purpose	Simplify complex queries, improve readability, and support recursion
Example Use	Filtering based on aggregate results, hierarchical data traversal
________________________________________

Question 5 : Describe the concept of SQL Normalization and its primary goals. 
Briefly explain the first three normal forms (1NF, 2NF, 3NF). 

Answer :

Concept of SQL Normalization
Normalization in SQL is the process of organizing data in a database to reduce redundancy (duplicate data) and improve data integrity.
It involves dividing a large, complex table into smaller, related tables and defining relationships between them using foreign keys.
Primary Goals of Normalization
Goal	Explanation
1. Eliminate Redundant Data	Avoid storing the same data in multiple places.
2. Ensure Data Integrity	Maintain consistency and accuracy of data across tables.
3. Simplify Data Maintenance	Make updates, insertions, and deletions more efficient and reliable.
4. Improve Query Efficiency	Structured data makes queries more precise and faster.

The First Three Normal Forms

1. First Normal Form (1NF) – Eliminate Repeating Groups
Rule:
•	Each column should contain atomic (indivisible) values.
•	Each record should be unique.
Example (Before 1NF):
StudentID	Name	Subjects
1	Raj	Math, English
After Applying 1NF:
StudentID	Name	Subject
1	Raj	Math
1	Raj	English
Data is now atomic — no multiple values in a single column.

2. Second Normal Form (2NF) – Remove Partial Dependency
Rule:
•	Must be in 1NF.
•	Every non-key attribute must depend on the whole primary key, not just part of it.
•	Applies to tables with composite primary keys.
Example (Before 2NF):
StudentID	CourseID	CourseName	StudentName
1	C1	SQL Basics	Raj
Here, CourseName depends only on CourseID, not on the full key (StudentID, CourseID).
After Applying 2NF:
•	Split into two tables:
Students Table:
StudentID	StudentName
1	Raj
•	Courses Table:
CourseID	CourseName
C1	SQL Basics
•	Enrollment Table:
StudentID	CourseID
1	C1
Now each non-key attribute depends fully on the primary key.

3. Third Normal Form (3NF) – Remove Transitive Dependency
Rule:
•	Must be in 2NF.
•	No transitive dependencies (non-key attributes should not depend on other non-key attributes).
Example (Before 3NF):
EmployeeID	EmployeeName	DeptID	DeptName
101	Alice	D1	HR
Here, DeptName depends on DeptID, not directly on EmployeeID.
After Applying 3NF:
•	Split into:
Employees Table:
EmployeeID	EmployeeName	DeptID
101	Alice	D1
•	Departments Table:
DeptID	DeptName
D1	HR
Now all non-key attributes depend only on the primary key.
Summary Table
Normal Form	Key Rule	Objective
1NF	No repeating groups; atomic values	Eliminate duplicate columns and multivalued fields
2NF	No partial dependency	Ensure full dependency on the whole primary key
3NF	No transitive dependency	Ensure non-key attributes depend only on the primary key
________________________________________

Question 6 :  Create a database named ECommerceDB and perform the following tasks

Answer : 
*/
# 1 : Creating DataBase
CREATE DATABASE ECommerceDB;
USE ECommerceDB;
# 2 : Creating Tables
CREATE TABLE Categories( 
	CategoryID INT PRIMARY KEY, 
	CategoryName VARCHAR(50) NOT NULL UNIQUE );
    
CREATE TABLE Products(
	ProductID INT PRIMARY KEY, 
	ProductName VARCHAR(100) NOT NULL UNIQUE,
	CategoryID INT, 
	Price DECIMAL(10,2) NOT NULL, 
	StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID));

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
JoinDate DATE );

CREATE TABLE Orders( 
	OrderID INT PRIMARY KEY, 
	CustomerID INT,
	OrderDate DATE NOT NULL,
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));

# 3 : Inserting Values
INSERT INTO Categories (CategoryID, CategoryName) VALUES
	(1, 'Electronics'),
    (2, 'Books'),
    (3, 'Home Goods'),
    (4, 'Apparel');
    
INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
	(101, 'Laptop Pro', 1, 1200.00, 50),
	(102, 'SQL Handbook', 2, 45.50, 200),
	(103, 'Smart Speaker', 1, 99.99, 150),
	(104, 'Coffee Maker', 3, 75.00, 80),
	(105, 'Novel : The Great SQL', 2, 25.00, 120),
	(106, 'Wireless Earbuds', 1, 150.00, 100),
	(107, 'Blender X', 3, 120.00, 60),
	(108, 'T-Shirt Casual', 4, 20.00, 300);

INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
	(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
	(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
	(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
	(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
	(1001, 1, '2023-04-26', 1245.50),
	(1002, 2, '2023-10-12', 99.99),
	(1003, 1, '2023-07-01', 145.00),
	(1004, 3, '2023-01-14', 150.00),
	(1005, 2, '2023-09-24', 120.00),
	(1006, 1, '2023-06-19', 20.00);

/*
Question 7 : Generate a report showing CustomerName, Email, and the 
TotalNumberofOrders for each customer. Include customers who have not placed 
any orders, in which case their TotalNumberofOrders should be 0. Order the results 
by CustomerName. 

Answer : 
*/

SELECT
    C.CustomerName,
    C.Email,
    COUNT(O.OrderID) AS TotalNumberofOrders
FROM
    Customers C
LEFT JOIN
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID, C.CustomerName, C.Email
ORDER BY
    C.CustomerName;
    
/*
Question 8 :  Retrieve Product Information with Category: Write a SQL query to 
display the ProductName, Price, StockQuantity, and CategoryName for all 
products. Order the results by CategoryName and then ProductName alphabetically. 

Answer :
*/

SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM 
    Products p
JOIN 
    Categories c 
ON 
    p.CategoryID = c.CategoryID
ORDER BY 
    c.CategoryName ASC,
    p.ProductName ASC;

/*
Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a 
Window Function (specifically ROW_NUMBER() or RANK()) to display the 
CategoryName, ProductName, and Price for the top 2 most expensive products in 
each CategoryName. 

Answer : 
*/

WITH RankedProducts AS (
    SELECT 
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName 
            ORDER BY p.Price DESC
        ) AS PriceRank
    FROM 
        Products p
    JOIN 
        Categories c 
    ON 
        p.CategoryID = c.CategoryID
)
SELECT 
    CategoryName,
    ProductName,
    Price
FROM 
    RankedProducts
WHERE 
    PriceRank <= 2
ORDER BY 
    CategoryName ASC,
    Price DESC;

/*
Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie 
rental company. The management team is looking to improve decision-making by 
analyzing existing customer, rental, and inventory data. 
Using the Sakila database, answer the following business questions to support key strategic 
initiatives. 
Tasks & Questions: 
1. Identify the top 5 customers based on the total amount they’ve spent. Include customer 
name, email, and total amount spent. 
2. Which 3 movie categories have the highest rental counts? Display the category name 
and number of times movies from that category were rented. 
3. Calculate how many films are available at each store and how many of those have 
never been rented. 
4. Show the total revenue per month for the year 2023 to analyze business seasonality. 
5. Identify customers who have rented more than 10 times in the last 6 months.

Answer :
*/

# 1 : Top 5 customers based on total amount spent

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    SUM(p.amount) AS total_amount_spent
FROM 
    customer c
JOIN 
    payment p 
ON 
    c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
ORDER BY 
    total_amount_spent DESC
LIMIT 5;

# 2 : Top 3 movie categories by rental count**

SELECT 
    cat.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category cat ON fc.category_id = cat.category_id
GROUP BY 
    cat.name
ORDER BY 
    rental_count DESC
LIMIT 3;

# 3️ : Films available at each store and how many were never rented

SELECT 
    s.store_id,
    COUNT(i.inventory_id) AS total_films,
    SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS never_rented_films
FROM 
    store s
JOIN 
    inventory i ON s.store_id = i.store_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    s.store_id
ORDER BY 
    s.store_id;

# 4️ : Total revenue per month for 2023

SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
WHERE 
    YEAR(p.payment_date) = 2023
GROUP BY 
    DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY 
    month;

# 5 : Customers who rented more than 10 times in the last 6 months

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(r.rental_id) AS rental_count
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
WHERE 
    r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    rental_count > 10
ORDER BY 
    rental_count DESC;

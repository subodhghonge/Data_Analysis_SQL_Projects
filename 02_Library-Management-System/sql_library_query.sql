SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- Project Task

-- Q1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Q2. Update an Existing Member's Address
UPDATE members
SET member_address = '110 Oak St'
WHERE member_id = 'C103';
SELECT * FROM members;

-- Q3. Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Q4 Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Q5. List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id --  COUNT(issued_id) as issued_count
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;

-- Q6. Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.
CREATE TABLE book_counts AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_book_isbn) as no_issued
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2;

-- Q7. Retrieve All Books in a Specific Category. 
SELECT * FROM books
Where category = "History";

-- Q8. Find Total Rental Income by Category
SELECT b.category, SUM(b.rental_price) AS rental_income
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1;

-- Q9. List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL 180 DAY;

-- Q10. List Employees with Their Branch Manager's Name and their branch details.
SELECT e1.*, b.manager_id, e2.emp_name as manager
FROM employees as e1
JOIN
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2
ON b.manager_id = e2.emp_id;

-- Q11. Create a Table of Books with Rental Price Above a Certain Threshold.
CREATE TABLE expensive_book AS
SELECT * FROM books
WHERE rental_price > 7;

-- Q12. Retrieve the List of Books Not Yet Returned.
SELECT DISTINCT ist.issued_book_name FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;
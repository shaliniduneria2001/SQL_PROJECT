CREATE DATABASE kaggle;

-- Use the database
USE kaggle;

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Genre VARCHAR(50),
    TotalCopies INT,
    AvailableCopies INT
);



INSERT INTO Books VALUES
(101, 'Half Girlfriend', 1, 'Romance', 5, 3),
(102, 'Harry Potter', 2, 'Fantasy', 4, 2),
(103, '1984', 3, 'Dystopian', 6, 6);

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

INSERT INTO Authors VALUES
(1, 'Chetan Bhagat'),
(2, 'J.K. Rowling'),
(3, 'George Orwell');


-- Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

INSERT INTO Members VALUES
(201, 'Shalini Devi', 'shalini@example.com', '2023-01-10'),
(202, 'Rahul Sharma', 'rahul@example.com', '2022-11-15');

-- IssuedBooks Table
CREATE TABLE IssuedBooks (
    IssueID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

INSERT INTO IssuedBooks VALUES
(301, 101, 201, '2025-07-01', NULL),
(302, 102, 202, '2025-07-10', '2025-07-20');

-- Sample Queries
SELECT * FROM Books;
SELECT * FROM Authors;
SELECT * FROM Members;
SELECT * FROM IssuedBooks;

-- 1. Show all books in the library
SELECT * FROM Books;

-- 2. Show all registered members
SELECT * FROM Members;

-- 3. Show all issued books
SELECT * FROM IssuedBooks;

-- 4. Add a new book to the library
INSERT INTO Books VALUES (104, 'Python', 4, 'Technical', 6, 6);

-- 5. Add a new member to the library
INSERT INTO Members VALUES (204, 'Neha Gupta', 'neha@example.com', '2025-07-29');

-- 6. Delete a book by its ID
DELETE FROM Books WHERE BookID = 104;

-- 7. Update available copies of a book
UPDATE Books SET AvailableCopies = 5 WHERE BookID = 101;

-- 8. List all books along with their author names
SELECT B.Title, A.AuthorName FROM Books B JOIN Authors A ON B.AuthorID = A.AuthorID;

-- 9. Show all books currently issued and not returned
SELECT B.Title, M.Name, I.IssueDate 
FROM IssuedBooks I
JOIN Books B 
ON I.BookID = B.BookID
JOIN Members M 
ON I.MemberID = M.MemberID
WHERE I.ReturnDate IS NULL;

-- 10. Show books with less than 2 available copies
SELECT * FROM Books WHERE AvailableCopies < 2;

-- 11. Count how many books each member has issued
SELECT M.Name, COUNT(I.IssueID) AS TotalIssued
FROM Members M
LEFT JOIN IssuedBooks I ON M.MemberID = I.MemberID
GROUP BY M.Name;

-- 12. Find the most issued book in the library
SELECT B.Title, COUNT(I.IssueID) AS TimesIssued
FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
GROUP BY B.Title
ORDER BY TimesIssued DESC
LIMIT 1;

-- 13. List books issued by a specific member
SELECT B.Title, I.IssueDate FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
WHERE I.MemberID = 201; 

-- 14. Find all members who have issued at least 1 book
SELECT DISTINCT M.MemberID, M.Name
FROM Members M
JOIN IssuedBooks IB ON M.MemberID = IB.MemberID;

-- 15. List all genres available in the library
SELECT DISTINCT Genre FROM Books;

-- 16. Count how many books are available in each genre
SELECT Genre, SUM(AvailableCopies) AS TotalAvailable
FROM Books
GROUP BY Genre;

-- 17. Find overdue books (issued more than 15 days ago and not returned)
SELECT B.Title, M.Name, I.IssueDate FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
JOIN Members M ON I.MemberID = M.MemberID
WHERE I.ReturnDate IS NULL AND DATEDIFF(CURDATE(), I.IssueDate) > 15;

-- 18. Show top 3 most issued books
SELECT B.Title, COUNT(I.IssueID) AS TimesIssued
FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
GROUP BY B.Title
ORDER BY TimesIssued DESC
LIMIT 3;

-- 19. Find members who have not issued any books
SELECT M.MemberID, M.Name FROM Members M
LEFT JOIN IssuedBooks I ON M.MemberID = I.MemberID
WHERE I.IssueID IS NULL;

-- 20. List all books issued in the current month
SELECT B.Title, I.IssueDate FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
WHERE MONTH(I.IssueDate) = MONTH(CURDATE()) AND YEAR(I.IssueDate) = YEAR(CURDATE());

-- 21. Find books issued and returned on the same day
SELECT B.Title, I.IssueDate FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
WHERE I.IssueDate = I.ReturnDate;

-- 22. Calculate total number of issued books per author
SELECT A.AuthorName, COUNT(I.IssueID) AS TotalIssued
FROM IssuedBooks I
JOIN Books B ON I.BookID = B.BookID
JOIN Authors A ON B.AuthorID = A.AuthorID
GROUP BY A.AuthorName;

-- 23. Show book with highest available copies
SELECT Title, AvailableCopies FROM Books
ORDER BY AvailableCopies DESC
LIMIT 1;

-- 24. Find members who have returned all their books
SELECT M.MemberID, M.Name
FROM Members M
WHERE NOT EXISTS (
    SELECT 1 FROM IssuedBooks I
    WHERE I.MemberID = M.MemberID AND I.ReturnDate IS NULL
);

-- 25. List authors who have written more than one book
SELECT A.AuthorName, COUNT(B.BookID) AS BookCount
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
GROUP BY A.AuthorName
HAVING COUNT(B.BookID) > 1;
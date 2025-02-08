-- Create Tables
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

select * from Books
select * from Customers
select * from Orders

--Easy Questions
-- 1) Retrieve all books in the "Fiction" genre:
select * from Books where genre='Fiction'

-- 2) Find books published after the year 1950:
select * from Books where published_year>1950

-- 3) List all customers from the Canada:
select * from customers WHERE country='Canada'
 
-- 4) Show orders placed in November 2023:
select * from Orders where order_date BETWEEN '1-11-2023' and '30-11-2023'

-- 5) Retrieve the total stock of books available:
select SUM(stock) from Books

-- 6) Find the details of the most expensive book:
select * from Books order by price Desc limit 1

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from Orders where quantity>1

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from Orders where total_amount>20

-- 9) List all genres available in the Books table:
select genre from Books group by genre
select DISTINCT genre from Books

-- 10) Find the book with the lowest stock:
select * from Books order by stock limit 5

-- 11) Calculate the total revenue generated from all orders:
select SUM(total_amount) from Orders  as total_revenue

---------------------
-- Advance Questions : 
select * from Books
select * from Customers
select * from Orders

-- 1) Retrieve the total number of books sold for each genre:
select b.genre,SUM(o.quantity)as total_no_of_books_sold from Books b
Join Orders o
ON o.book_id=b.book_id
group by  genre 


-- 2) Find the average price of books in the "Fantasy" genre:
select AVG(price) from Books where genre='Fantasy'


-- 3) List customers who have placed at least 2 orders:
--Method 1 without Join
select customer_id,Count() as Total_Orders from Order_Count
Group by customer_id
Having Count(quantity)>=2

--Method 2 with Join to get customer name
select o.customer_id, c.name ,COUNT(o.order_id) as Order_Count 
from Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id)>=2


-- 4) Find the most frequently ordered book:
select b.book_id,b.title,COUNT(o.order_id) as Orders_Count
from Books b
JOIN Orders o
ON b.book_id=o.book_id
GROUP BY b.book_id,b.title
ORDER BY Orders_Count DESC
LIMIT 1


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select book_id,title,genre,price from Books 
Where genre='Fantasy'
ORDER BY price DESC
LIMIT 3


-- 6) Retrieve the total quantity of books sold by each author:
select b.author,SUM(o.quantity) as Total_Books_Sold
FROM Books b
JOIN Orders o
ON b.book_id=o.book_id
GROUP BY b.author


-- 7) List the cities where customers who spent over $30 are located:
select DISTINCT c.city, o.total_amount 
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
WHERE o.total_amount > 30


-- 8) Find the customer who spent the most on orders:
select c.customer_id, c.name,SUM(o.total_amount) AS Total_Spent
from Customers c
JOIN Orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC
LIMIT 1


--9) Calculate the stock remaining after fulfilling all orders:
select * from Books
select * from Customers
select * from Orders


select b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) as Ordered_Quantity,
       b.stock-COALESCE(SUM(o.quantity),0) as Remaining_stock 
from Books b
LEFT JOIN Orders o
ON b.book_id=o.book_id
GROUP BY b.book_id

-----------------------------------------------------------







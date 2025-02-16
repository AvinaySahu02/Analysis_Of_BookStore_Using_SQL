Create database OnlineBookStore;
use OnlineBookStore;

Select * from books;
select * from customers_bookstore;
select * from orders_bookstore;

-- 1) Retrieve all books in the "Fiction" genre:
Select * from books
where genre="Fiction";

-- 2) Find books published after the year 1950:
Select * from books 
where published_year > 1950;

-- 3) List all customers from the Canada:
select * from customers_bookstore
where country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders_bookstore
where Order_Date between '2023-11-01' and '2023-11-31';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_Books from books;

-- 6) Find the details of the most expensive book:
Select * from books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders_bookstore
where quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders_bookstore
where total_amount > 20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select * from books
order by stock
limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as revenue
from orders_bookstore;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(o.Quantity) as Total_Books_Sold
from orders_bookstore o
join books b on o.book_id=b.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price from books
where genre="Fantasy";


-- 3) List customers who have placed at least 2 orders:
select o.customer_id, c.name, count(o.order_id) as order_count
from orders_bookstore o
join customers_bookstore c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(o.order_id) >=2;

-- 4) Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as order_count
from orders_bookstore o
join books b on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre='Fantasy'
order by price desc
limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) as total_books_count
from orders_bookstore o
join books b on o.book_id=b.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city, total_amount
from orders_bookstore o
join customers_bookstore c on o.customer_id=c.customer_id
where o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from orders_bookstore o
join customers_bookstore c on o.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT 
    b.book_id, 
    b.title, 
    b.stock, 
    COALESCE(SUM(o.quantity), 0) AS order_quantity,
    b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_quantity
FROM books b
LEFT JOIN orders_bookstore o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    contact_no VARCHAR(15) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES Customers(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL
);


INSERT INTO Customers (customer_id, customer_name, email, city, contact_no) VALUES
(101, 'Amit Sharma', 'amit@gmail.com', 'Delhi', '9876543210'),
(102, 'Rahul Verma', 'rahul@gmail.com', 'Mumbai', '9876543211'),
(103, 'Priya Singh', 'priya@gmail.com', 'Delhi', '9876543212'),
(104, 'Neha Kapoor', 'neha@gmail.com', 'Pune', '9876543213');

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(501, 101, '2024-01-05'),
(502, 101, '2024-01-15'),
(503, 102, '2024-01-10'),
(504, 103, '2024-02-05'),
(505, 103, '2024-01-20'),
(506, 103, '2024-01-25'),
(507, 104, '2024-03-10');



Problem 1:
Problem Statement 1
Write an SQL query to retrieve the customer ID, customer name, email, city, and contact number of customers who:
Have made more than one order.
Have placed at least one order during January 2024.
Display the results in ascending order of customer ID.
Use the tables Customers and Orders with appropriate attributes.

SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.contact_no
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.email, 
    c.city, 
    c.contact_no
HAVING 
    COUNT(o.order_id) > 1
    AND COUNT(CASE WHEN o.order_date >= '2024-01-01' AND o.order_date < '2024-02-01' THEN 1 END) >= 1
ORDER BY 
    c.customer_id ASC;
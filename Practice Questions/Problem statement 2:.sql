Problem statement 2:

Problem Statement: Customer Order Conversion Analysis
An e-commerce platform wants to analyze the conversion rate of customers across different stages of the shopping journey.

You are given the following tables:

site_sessions — stores customer website visits.

product_interest — stores sessions where customers showed interest in a product.

completed_orders — stores sessions where customers successfully placed an order.

Write a SQL query to calculate the following conversion rates:

Interest Conversion Rate – Percentage of unique sessions that showed product interest out of all unique website sessions.

Order Conversion Rate – Percentage of unique sessions that completed an order out of all unique product-interest sessions.

Overall Order Conversion Rate – Percentage of unique sessions that completed an order out of all unique website sessions.

The result should contain three columns:
interest_conversion
order_conversion
overall_conversion


CREATE TABLE site_sessions (
    session_id INT
);

CREATE TABLE product_interest (
    session_id INT
);

CREATE TABLE completed_orders (
    session_id INT
);

INSERT INTO site_sessions (session_id) VALUES
(101), (102), (103), (104), (105), (106), (107), (108), (109), (110);

INSERT INTO product_interest (session_id) VALUES
(101), (102), (103), (104), (105), (105), (107);

INSERT INTO completed_orders (session_id) VALUES
(101), (103), (105), (105);



WITH counts AS (
    SELECT 
        (SELECT COUNT(DISTINCT session_id) FROM site_sessions) AS total_sessions,
        (SELECT COUNT(DISTINCT session_id) FROM product_interest) AS interest_sessions,
        (SELECT COUNT(DISTINCT session_id) FROM completed_orders) AS order_sessions
)
SELECT 
    ROUND((interest_sessions::DECIMAL / NULLIF(total_sessions, 0)) * 100, 2) AS interest_conversion,
    ROUND((order_sessions::DECIMAL / NULLIF(interest_sessions, 0)) * 100, 2) AS order_conversion,
    ROUND((order_sessions::DECIMAL / NULLIF(total_sessions, 0)) * 100, 2) AS overall_conversion
FROM counts;
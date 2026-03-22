--
=================================================================DATABASE SELECTION=====================================================================
--
USE KAGGLE_1;
--
:search: BASIC DATA EXPLORATION
--
--Preview orders data
SELECT * FROM orders LIMIT 10;

--Count total records
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products FROM products;

--View products table 
SELECT * FROM products;

--Selected columns from orders
SELECT order_id,order_date,payment_method FROM orders;
--
:payment: PAYMENT ANALYSIS
--
--Orders paid via Card
SELECT * FROM orders WHERE payment_method='Card';

--Total card payments
SELECT COUNT(*) AS total_card_payments FROM orders
WHERE payment_method='Card';

--Most common payment method
SELECT payment_method, COUNT(*) AS total_usuage FROM orders
GROUP BY payment_method
ORDER BY total_usuage DESC LIMIT 1;
-- 
:sales: SALES ANALYSIS
--
--Total quantity sold
SELECT SUM(quantity) AS total_sales
FROM orders;

-- Average quantity per order
SELECT AVG(quantity) AS avg_quantity FROM orders;
--
:users: CUSTOMER ANALYSIS
--
--Customer per city
SELECT city,COUNT(*) AS customer_count FROM customers
GROUP BY city
ORDER BY customer_count DESC;

--Top 10 cities with most customers
SELECT city,COUNT(*) AS popular_customer_areas FROM customers
GROUP BY city
ORDER BY popular_customer_areas DESC
LIMIT 10;

--Top 10 highest spending customers
SELECT c.customer_id, SUM(o.quantity*p.price) AS TOTAL_SPENDING
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.customer_id
ORDER BY TOTAL_SPENDING DESC
LIMIT 10;

--Average spending per customers
SELECT AVG(customer_total_spend) AS average_spending_per_customer
FROM (-- FIRSTLY FINDING TOTAL SPENDING OF EACH customers
SELECT c.customer_id,SUM(p.price*o.quantity) AS customer_total_spend
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.customer_id
)       
AS customer_spend_table;
--
:shopping: PRODUCT ANALYSIS
--
--Total price of all products
SELECT SUM(price) AS total_product_price FROM products;

--Most popular product (by quantity sold)
SELECT p.product_name,SUM(o.quantity) AS total_quantity_sold 
FROM products p
JOIN orders o ON p.product_id=o.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

--Category generating highest revenue
SELECT p.category AS "Product Category", SUM(p.price*o.quantity) AS "Total Revenue"
FROM products p
JOIN orders o ON p.product_id=o.product_id
GROUP BY p.category
ORDER BY "Total Revenue" DESC
LIMIT 1;

--Category selling most units
SELECT p.category AS product_category, SUM(o.quantity) AS total_units_sold
FROM products p
JOIN orders  o ON p.product_id=o.product_id 
GROUP BY p.category
ORDER BY total_units_sold DESC
LIMIT 1;
--
🌏 REVENUE ANALYSIS
--
--City generating highest revenue
SELECT c.city, sum(p.price*o.quantity) AS "TOTAL REVENUE"
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.city
ORDER BY "TOTAL REVENUE" DESC
LIMIT 1;

--Month with highest sales
SELECT MONTHNAME(o.order_date) AS month_name,
SUM(o.quantity*p.price) AS total_monthly_sales FROM orders o        
JOIN products p ON o.product_id=p.product_id
GROUP BY month_name
ORDER BY total_monthly_sales DESC
LIMIT 1;

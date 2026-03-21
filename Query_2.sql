USE KAGGLE_1;
SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customers;
SELECT * FROM products;
SELECT COUNT(*) FROM products;
SELECT order_id,order_date,payment_method FROM orders;
SELECT * FROM orders WHERE payment_method='Card'; 
SELECT COUNT(*) AS total_card_payments 
       FROM orders;
SELECT * FROM orders 
       ORDER BY product_id; 
-- this query gives sum of total sold products
SELECT SUM(quantity) AS total_sales
       FROM orders;

-- IT gives total customers of each city
SELECT city,COUNT(*) AS customer_count
       FROM customers
       GROUP BY city
       ORDER BY customer_count DESC;

-- this gives total sum of price column 
SELECT SUM(price) 
       FROM products;

-- this query gives list of top 10 cities where we have most customers
SELECT city,COUNT(*) AS popular_customer_areas FROM customers
       GROUP BY city
       ORDER BY popular_customer_areas DESC
       LIMIT 10;

-- this will show you the single most popular product based on total quantity sold
SELECT p.product_name,SUM(o.quantity) AS total_quantity_sold 
       FROM products p
       JOIN orders o ON p.product_id=o.product_id
       GROUP BY p.product_name
       ORDER BY total_quantity_sold DESC
       LIMIT 1;

-- this will give average of quantity column from orders tables 
SELECT AVG(quantity) FROM orders;

-- it gives product category which generates the  most revenue 
SELECT p.category AS "Product Category", SUM(p.price*o.quantity) AS "Total Revenue"
       FROM products p
       JOIN orders o ON p.product_id=o.product_id
       GROUP BY p.category
       ORDER BY "Total Revenue" DESC
       LIMIT 1;

-- it will give which city genertes the most revenue
SELECT c.city, sum(p.price*o.quantity) AS "TOTAL REVENUE"
       FROM customers c
       JOIN orders o ON c.customer_id=o.customer_id
       JOIN products p ON o.product_id=p.product_id
       GROUP BY c.city
       ORDER BY "TOTAL REVENUE" DESC
       LIMIT 1;
-- THIS WILL GIVE TOP 10 HIGHEST SPENDING CUSTOMERS
SELECT c.customer_id, SUM(o.quantity*p.price) AS TOTAL_SPENDING
       FROM customers c
       JOIN orders o ON c.customer_id=o.customer_id
	   JOIN products p ON o.product_id=p.product_id
       GROUP BY c.customer_id
	   ORDER BY TOTAL_SPENDING DESC
	   LIMIT 10;
-- WHICH MONTH HAS THE HIGHEST SALE       
SELECT MONTHNAME(o.order_date) AS month_name,
      SUM(o.quantity*p.price) AS total_monthly_sales
	  FROM orders o        
      JOIN products p ON o.product_id=p.product_id
      GROUP BY month_name
      ORDER BY total_monthly_sales DESC
      LIMIT 1;
-- WHAT IS THE AVERAGE SPENDING PER CUSTOMER
SELECT AVG(customer_total_spend) AS average_spending_per_customer
       FROM (-- FIRSTLY FINDING TOTAL SPENDING OF EACH customers
            SELECT c.customer_id,SUM(p.price*o.quantity) AS customer_total_spend
            FROM customers c 
            JOIN orders o ON c.customer_id=o.customer_id
            JOIN products p ON o.product_id=p.product_id
			GROUP BY c.customer_id
)           AS customer_spend_table;
-- THIS WILL TELL THAT WHICH PRODUCT CATEGORY SALES MOST UNITS
SELECT p.category AS product_category, SUM(o.quantity) AS total_units_sold
      FROM products p
      JOIN orders  o ON p.product_id=o.product_id 
      GROUP BY p.category
      ORDER BY total_units_sold DESC
      LIMIT 1;
-- WHICH IS THE MOST COMMON PAYMENT METHOD
SELECT payment_method, COUNT(*) AS total_usuage
      FROM orders
      GROUP BY payment_method
      ORDER BY total_usuage DESC
      LIMIT 1;
      

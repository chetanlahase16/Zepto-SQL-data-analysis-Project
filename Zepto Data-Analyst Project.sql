use zepto;
drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountpercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);


-- Data Exploration
SELECT COUNT(*) FROM zepto;

-- Sample data
SELECT * FROM zepto
LIMIT 10;

-- Null values
SELECT * FROM zepto
WHERE name is NULL
OR
Category is NULL
OR
mrp is NULL
OR
discountPercent is NULL
OR
availableQuantity is NULL
OR
discountedSellingPrice is NULL
OR
weightInGms is NULL
OR
outOfStock is NULL
OR
quantity is NULL;

-- different product categories

SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

-- product names present multiple times
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) >1
ORDER BY count(sku_id) DESC;

-- data Cleaning

-- product with price
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0; 

SET SQL_SAFE_UPDATES = 0;

DELETE FROM zepto
WHERE mrp = 0;

SET SQL_SAFE_UPDATES = 1;

-- Convert paise to rupees
update zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM zepto;

-- Business Questions

-- 1.Find top 10 best-value products based on discount percentage

Select DISTINCT name, discountedSellingPrice, mrp from zepto
ORDER BY discountedSellingPrice DESC
limit 10;


-- 2.What are the products with high-MRP products that are currently out of stock

SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--  3. Calculate Estimated revenue for each product category

SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY CATEGORY
ORDER BY total_revenue;

-- 4.Find out all products (MRP > ₹500) with 10% discount

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp >500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


-- 5.identified top 5 categories offering highest average discounts
SELECT category,
ROUND(avg(discountPercent),2) as avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

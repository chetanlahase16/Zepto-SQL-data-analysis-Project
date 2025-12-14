🛒 Zepto Product Data Analysis using SQL
📌 Project Overview

This project focuses on exploring, cleaning, and analyzing product-level data from Zepto, a quick-commerce platform.
The goal is to understand product availability, pricing behavior, discounts, and category-wise revenue using SQL.

The project covers:

Data exploration

Data cleaning

Business-oriented analysis using SQL queries

🧱 Database & Table Setup
USE zepto;

DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);

🔍 Data Exploration
Total Records
SELECT COUNT(*) FROM zepto;

Sample Data
SELECT *
FROM zepto
LIMIT 10;

Check for NULL Values
SELECT *
FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

Distinct Product Categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

In-Stock vs Out-of-Stock Products
SELECT outOfStock, COUNT(sku_id) AS product_count
FROM zepto
GROUP BY outOfStock;

Products with Multiple SKUs
SELECT name, COUNT(sku_id) AS number_of_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;

🧹 Data Cleaning
Identify Invalid Pricing
SELECT *
FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

Remove Invalid Records
SET SQL_SAFE_UPDATES = 0;

DELETE FROM zepto
WHERE mrp = 0;

SET SQL_SAFE_UPDATES = 1;

Convert Prices from Paise to Rupees
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

📊 Business Insights & Analysis
1️⃣ Top 10 Best-Value Products (Based on Price)
SELECT DISTINCT name, mrp, discountedSellingPrice
FROM zepto
ORDER BY discountedSellingPrice DESC
LIMIT 10;

2️⃣ High-MRP Products That Are Out of Stock
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;

3️⃣ Estimated Revenue by Category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

4️⃣ Premium Products with Low Discounts

(Products priced above ₹500 with less than 10% discount)

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

5️⃣ Top 5 Categories Offering Highest Average Discounts
SELECT category,
       ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

🛠 Skills Demonstrated

SQL Data Modeling

Data Cleaning & Validation

Aggregations & Grouping

Business-driven SQL analysis

Real-world pricing and inventory insights

📌 Conclusion

This project demonstrates how SQL can be used to clean raw product data and extract meaningful business insights related to pricing, discounts, stock availability, and revenue.
It reflects practical, real-world analysis commonly required in Data Analyst / BI roles.

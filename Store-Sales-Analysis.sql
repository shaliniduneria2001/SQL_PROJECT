USE KAGGLE;
SELECT  * FROM STORE_SALES;

-- 1.Show all the sales records from the table.
SELECT  * FROM STORE_SALES;
-- 2.Count total number of records (rows) in the dataset.
SELECT COUNT(*) FROM STORE_SALES;
-- 3.List all unique store numbers.
SELECT DISTINCT STORE AS STORE_NUMBER FROM STORE_SALES;
-- 4.Find the total sales amount in the dataset.
SELECT SUM(SALES) AS TOTAL_SALES_AMOUNT FROM STORE_SALES;
-- 5.Show records where sales are greater than 250.
SELECT * FROM STORE_SALES
WHERE SALES > 250;
-- 6.Find how many records have promotions (promo = 1).
SELECT * FROM STORE_SALES
WHERE PROMO = 1;
-- 7.Count how many days were holidays (holiday = 1).
SELECT COUNT(*) FROM STORE_SALES
WHERE HOLIDAY = 1; 
-- 8.Show sales on a specific date (e.g., '01/01/2022').
SELECT * FROM STORE_SALES
WHERE DATE = '01/01/2022';
-- 9.What is the highest sales amount recorded?
SELECT MAX(SALES) AS HIGHEST_SALES_AMOUNT FROM STORE_SALES
LIMIT 1;
-- 10.What is the lowest sales amount recorded?
SELECT MIN(SALES) LOWEST_SALES_AMOUNT FROM STORE_SALES
LIMIT 1;

-- 11.Calculate total sales per store.
SELECT STORE,SUM(SALES) AS TOTAL_SALES FROM STORE_SALES
GROUP BY STORE;
-- 12.Find the average sales per store.
SELECT STORE, AVG(SALES) AS AVERAGE_SALES 
FROM  STORE_SALES
GROUP BY STORE;
-- 13.Find average sales on promotion days vs. non-promotion days.
SELECT PROMO, AVG(SALES) AS AVERAGE_SALES 
FROM STORE_SALES
GROUP BY PROMO;
-- 14.Show total sales on holidays only.
SELECT SUM(SALES) AS HOLIDAY_SALES 
FROM STORE_SALES
WHERE HOLIDAY = 1;
-- 15.Find total number of days each store was active.
SELECT STORE, COUNT(*) AS DAYS_ACTIVE 
FROM STORE_SALES
GROUP BY STORE;
-- 16.Which store made the highest single-day sale?
SELECT STORE,SALES FROM STORE_SALES
WHERE SALES = (SELECT MAX(SALES) FROM  STORE_SALES);
-- 17.List top 3 days with highest overall sales.
SELECT date, sales
FROM store_sales
ORDER BY sales DESC
LIMIT 3;
-- 18.Count how many days store 1 had sales above ₹200.
SELECT COUNT(*) AS high_sales_days
FROM store_sales
WHERE store = 1 AND sales > 200;
-- 19.Show total sales for each date (grouped by date).
SELECT date, SUM(sales) AS daily_sales
FROM store_sales
GROUP BY date
ORDER BY date;
-- 20.List all dates when both holiday and promotion were active.
SELECT date, store, sales
FROM store_sales
WHERE promo = 1 AND holiday = 1;

-- 21.Rank days by total sales.
SELECT DATE, SUM(SALES) AS DAILY_SALES,
RANK() OVER (ORDER BY SUM(SALES) DESC) AS SALES_RANK
FROM store_sales
GROUP BY DATE;


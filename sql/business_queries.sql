-- =====================================================
-- Load Data (DuckDB)
-- =====================================================

CREATE OR REPLACE TABLE online_retail AS
SELECT *
FROM read_csv_auto('../data/online_retail_cleaned.csv');

-- =====================================================
-- 1. Top Products by Revenue
-- Which products generated the most revenue?
-- =====================================================

SELECT
Description,
SUM(Revenue) AS Total_Revenue
FROM online_retail
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

-- =====================================================
-- 2. Monthly Revenue Trend
-- How does revenue change month by month?
-- =====================================================

SELECT
Year,
Month,
ROUND(SUM(Revenue), 2) AS Monthly_Revenue
FROM online_retail
GROUP BY Year, Month
ORDER BY Year, Month;

-- =====================================================
-- 3. Revenue by Country
-- Which countries generate the most revenue?
-- =====================================================

SELECT
Country,
ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM online_retail
GROUP BY Country
ORDER BY Total_Revenue DESC;

-- =====================================================
-- 4. Average Order Value (AOV)
-- What is the average revenue per invoice?
-- =====================================================

WITH order_totals AS (
SELECT
Invoice,
SUM(Revenue) AS Order_Value
FROM online_retail
GROUP BY Invoice
)

SELECT
ROUND(AVG(Order_Value), 2) AS Average_Order_Value
FROM order_totals;

-- =====================================================
-- 5. Customer Purchase Frequency
-- Which customers place orders most frequently?
-- =====================================================

SELECT
"Customer ID",
COUNT(DISTINCT Invoice) AS Number_Of_Orders
FROM online_retail
GROUP BY "Customer ID"
ORDER BY Number_Of_Orders DESC
LIMIT 20;

-- =====================================================
-- 6. Top Customers by Revenue
-- Which customers spend the most money?
-- =====================================================

SELECT
"Customer ID",
ROUND(SUM(Revenue), 2) AS Total_Spend
FROM online_retail
GROUP BY "Customer ID"
ORDER BY Total_Spend DESC
LIMIT 20;

-- =====================================================
-- 7. RFM Analysis
-- Rank customers by Recency, Frequency and Monetary Value
-- =====================================================

WITH customer_rfm AS (
SELECT
"Customer ID",

```
    DATE_DIFF(
        'day',
        MAX(InvoiceDate),
        (SELECT MAX(InvoiceDate) FROM online_retail)
    ) AS Recency,

    COUNT(DISTINCT Invoice) AS Frequency,

    SUM(Revenue) AS Monetary

FROM online_retail
GROUP BY "Customer ID"
```

),

rfm_scores AS (
SELECT
*,
NTILE(5) OVER (ORDER BY Recency ASC) AS R_Score,
NTILE(5) OVER (ORDER BY Frequency DESC) AS F_Score,
NTILE(5) OVER (ORDER BY Monetary DESC) AS M_Score
FROM customer_rfm
)

SELECT
*,
CONCAT(R_Score, F_Score, M_Score) AS RFM_Segment
FROM rfm_scores
ORDER BY Monetary DESC;

-- =====================================================
-- 8. Best Sales Day of the Week
-- Which weekday generates the most revenue?
-- =====================================================

SELECT
DayOfWeek,
ROUND(SUM(Revenue), 2) AS Revenue
FROM online_retail
GROUP BY DayOfWeek
ORDER BY Revenue DESC;

-- =====================================================
-- 9. Best Selling Products by Quantity
-- Which products sell the most units?
-- =====================================================

SELECT
Description,
SUM(Quantity) AS Units_Sold
FROM online_retail
GROUP BY Description
ORDER BY Units_Sold DESC
LIMIT 10;

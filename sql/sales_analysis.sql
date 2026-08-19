-- =====================================================
-- SALES REVENUE ANALYSIS
-- Dataset Overview
-- =====================================================

-- Total rows, unique orders, customers and products

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_products
FROM sales_data;

-- =====================================================
-- 1. OVERALL SALES & PROFIT
-- =====================================================

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_data;

-- =====================================================
-- 2. CATEGORY PERFORMANCE
-- =====================================================

-- Sales and profit by category

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(AVG(discount), 2) AS avg_discount
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;


-- Profit margin by category

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin
FROM sales_data
GROUP BY category
ORDER BY profit_margin DESC;

-- =====================================================
-- 3. MONTHLY SALES PERFORMANCE
-- =====================================================

-- Monthly sales and profit

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY month
ORDER BY month;


-- Month-over-Month sales growth

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS total_sales,
        LAG(SUM(sales)) OVER (
            ORDER BY DATE_TRUNC('month', order_date)
        ) AS prev_month_sales
    FROM sales_data
    GROUP BY month
)
SELECT
    month,
    total_sales,
    prev_month_sales,
    ROUND(
        (total_sales - prev_month_sales)
        / NULLIF(prev_month_sales, 0) * 100,
        2
    ) AS mom_growth
FROM monthly_sales
ORDER BY month;


-- =====================================================
-- 4. CUSTOMER ANALYSIS
-- =====================================================

-- Top 10 customers by revenue

SELECT
    customer_id,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS no_of_orders,
    ROUND(
        SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS avg_order_value
FROM sales_data
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 customers by profit

SELECT
    customer_id,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS no_of_orders,
    ROUND(
        SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS avg_order_value
FROM sales_data
GROUP BY customer_id
ORDER BY total_profit DESC
LIMIT 10;

-- =====================================================
-- 5. PRODUCT PERFORMANCE
-- =====================================================

-- Top 10 products by sales

SELECT
    product_id,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM sales_data
GROUP BY product_id
ORDER BY sales_rank
LIMIT 10;

-- Top 10 products by profit

SELECT
    product_id,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    RANK() OVER (
        ORDER BY SUM(profit) DESC
    ) AS profit_rank
FROM sales_data
GROUP BY product_id
ORDER BY profit_rank
LIMIT 10;

-- =====================================================
-- 6. LOSS-MAKING TRANSACTIONS
-- =====================================================

-- Overall loss-making transaction summary

SELECT
    COUNT(*) AS loss_making_rows,
    SUM(sales) AS sales_from_loss_rows,
    SUM(profit) AS total_loss
FROM sales_data
WHERE profit < 0;


-- Products with the largest losses from individual transactions

SELECT
    product_id,
    COUNT(*) AS loss_transactions,
    SUM(sales) AS loss_sales,
    SUM(profit) AS total_loss
FROM sales_data
WHERE profit < 0
GROUP BY product_id
ORDER BY total_loss
LIMIT 10;

-- Loss-making transactions by product and sub-category

SELECT
    product_id,
    category,
    sub_category,
    ROUND(AVG(discount), 2) AS avg_discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_data
WHERE profit < 0
GROUP BY product_id, category, sub_category
ORDER BY total_profit;


-- =====================================================
-- 8. GEOGRAPHIC ANALYSIS
-- =====================================================

-- Regional performance

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- Top 10 cities by sales

SELECT
    city,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin
FROM sales_data
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;


-- =====================================================
-- 9. SUB-CATEGORY ANALYSIS
-- =====================================================

-- Sub-category profitability

SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin
FROM sales_data
GROUP BY sub_category
ORDER BY profit_margin ASC;

-- Most profitable sub-category within each category

WITH ranked_subcategories AS (
    SELECT
        category,
        sub_category,
        SUM(profit) AS total_profit,
        RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(profit) DESC
        ) AS profit_rank
    FROM sales_data
    GROUP BY category, sub_category
)
SELECT *
FROM ranked_subcategories
WHERE profit_rank = 1;


-- =====================================================
-- 10. CUSTOMER SEGMENT ANALYSIS
-- =====================================================

-- Segment performance

SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;


-- Most profitable customer segment within each region

WITH ranked_segments AS (
    SELECT
        region,
        segment,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        ROUND(
            SUM(profit) / NULLIF(SUM(sales), 0) * 100,
            2
        ) AS profit_margin,
        RANK() OVER (
            PARTITION BY region
            ORDER BY SUM(profit) DESC
        ) AS profit_rank
    FROM sales_data
    GROUP BY region, segment
)
SELECT *
FROM ranked_segments
WHERE profit_rank = 1;
